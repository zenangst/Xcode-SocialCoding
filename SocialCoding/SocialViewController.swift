class SocialViewController: NSViewController {

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

  override func loadView() {
    let scrollView = NSScrollView(frame:CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 1000, height: 1000)))
    scrollView.autohidesScrollers = true
    scrollView.documentView = textView
    scrollView.hasVerticalScroller = true

    view = scrollView
    view.autoresizesSubviews = true
    view.layer?.backgroundColor = NSColor.clearColor().CGColor
    view.wantsLayer = true
  }
}
