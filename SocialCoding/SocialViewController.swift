class SocialViewController: NSViewController {

  override func loadView() {
    let scrollView = NSScrollView(frame:CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 1000, height: 1000)))
    scrollView.autohidesScrollers = true
    scrollView.hasVerticalScroller = true

    view = scrollView
    view.layer?.backgroundColor = NSColor.clearColor().CGColor
    view.wantsLayer = true
  }
}
