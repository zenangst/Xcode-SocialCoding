import Cocoa

var plugin: SocialCodingPlugin? = nil

class SocialCodingPlugin: NSObject {

  var sidebarWidth: CGFloat = 0

  lazy var popover: NSPopover = { [unowned self] in
    let popover = NSPopover()
    popover.animates = true
    popover.behavior = .Transient
    popover.contentViewController = self.socialController
    return popover
  }()

  lazy var socialController: SocialViewController = SocialViewController()

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
