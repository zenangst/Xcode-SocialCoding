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

class SocialCodingPlugin: NSObject {

  lazy var textView: NSTextView =  {
    let textView = NSTextView()
    textView.backgroundColor = NSColor(deviceRed: 254/255, green: 253/255, blue: 204/255, alpha: 1.0)
    return textView
  }()

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }

  override init() {
    super.init()

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

extension NSRulerView {

  func zen_annotationAtSidebarPoint(point: CGPoint) -> AnyObject? {
    let annotation = zen_annotationAtSidebarPoint(point)

    if let plugin = plugin {
      if annotation == nil && point.x < CGFloat(sidebarWidth) {
        let line = lineNumberForPoint(point)
        let attributedString = NSAttributedString(string: "foo")
        plugin.textView.textStorage?.setAttributedString(attributedString)

        var (a0, a1) = (CGRect(), CGRect())
        getParagraphRect(&a0, firstLineRect: &a1, forLineNumber: 60)

        plugin.textView.frame = NSRect(x: NSWidth(frame)+1.0, y: a0.origin.y, width: 500, height: 10)

        scrollView?.addSubview(plugin.textView)
      } else if plugin.textView.superview != nil {
        plugin.textView.removeFromSuperview()
      }
    }

    return annotation
  }

  func zen_drawLineNumbersInSidebarRect(rect: CGRect, indexes: Int, indexCount: Int, linesToInvert: AnyObject, linesToReplace: AnyObject, getParaRectBlock: AnyObject) {

    lockFocus()


    
    unlockFocus()

    self.zen_drawLineNumbersInSidebarRect(rect, indexes: indexes, indexCount: indexCount, linesToInvert: linesToInvert, linesToReplace: linesToReplace, getParaRectBlock: getParaRectBlock)
  }

  func zen_drawBackground(color: NSColor, atLine: Int) {
  }
}
