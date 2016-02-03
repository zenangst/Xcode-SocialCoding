import Cocoa

var plugin: SocialCodingPlugin? = nil

extension NSObject {

  class func pluginDidLoad(bundle: NSBundle) {
    guard let appName = NSBundle.mainBundle().infoDictionary?["CFBundleName"] as? String
      where plugin == nil && appName == "Xcode" else {
        return
    }

    plugin = SocialCodingPlugin()
  }
}

class SocialViewController: NSViewController {

  override func loadView() {
    let scrollView = NSScrollView(frame:CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 1000, height: 1000)))
    scrollView.hasVerticalScroller = true
    scrollView.autohidesScrollers = true

    view = scrollView
    view.layer?.backgroundColor = NSColor.clearColor().CGColor
    view.wantsLayer = true
  }
}

class SocialCodingPlugin: NSObject {

  var sidebarWidth: CGFloat = 0

  lazy var popover: NSPopover = { [unowned self] in
    let popover = NSPopover()
    popover.animates = true
    popover.behavior = .Transient
    popover.contentViewController = self.socialController
    return popover
  }()

  lazy var socialController: SocialViewController = { [unowned self] in
    let controller = SocialViewController()
    controller.view.autoresizesSubviews = true

    guard let scrollView = controller.view as? NSScrollView else { return controller }
    scrollView.documentView = self.textView

    return controller
  }()

  lazy var textView: NSTextView = { [unowned self] in
    let textView = NSTextView()
    textView.autoresizingMask = [
      .ViewMinXMargin,
      .ViewWidthSizable,
      .ViewMaxXMargin,
      .ViewMinYMargin,
      .ViewHeightSizable,
      .ViewMaxYMargin,
    ]
    textView.editable = false
    textView.textContainerInset = NSSize(width: 10, height: 10)

    return textView
  }()

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }

  override init() {
    super.init()

    sidebarWidth = 2.0

    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "applicationDidFinishLaunching:",
      name: NSApplicationDidFinishLaunchingNotification,
      object: nil)
  }

  func applicationDidFinishLaunching(notification: NSNotification) {
    guard let aClass = NSClassFromString("DVTTextSidebarView")
      else { return }

    swizzle(aClass,
      exchange: "annotationAtSidebarPoint:",
      with: "zen_annotationAtSidebarPoint:")

    swizzle(aClass,
      exchange: "sidebarWidth",
      with: "zen_sidebarWidth")

    swizzle(aClass,
      exchange: "_drawLineNumbersInSidebarRect:foldedIndexes:count:linesToInvert:linesToReplace:getParaRectBlock:",
      with: "zen_drawLineNumbersInSidebarRect:foldedIndexes:count:linesToInvert:linesToReplace:getParaRectBlock:")
  }

  func swizzle(aClass: AnyClass, exchange: Selector, with: Selector) {
    method_exchangeImplementations(
      class_getInstanceMethod(aClass, exchange),
      class_getInstanceMethod(aClass, with)
    )
  }
}
