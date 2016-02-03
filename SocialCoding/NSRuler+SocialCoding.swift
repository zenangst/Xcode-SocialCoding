extension NSRulerView {

  func drawBackground(color: NSColor, atLine: UInt) {
    var (a0, a1) = (CGRect(), CGRect())
    getParagraphRect(&a0, firstLineRect: &a1, forLineNumber: atLine)
    a0.size.width = 2
    color.set()
    NSRectFill(a0)
  }

  func drawText(string: String, atLine: UInt) {
    var (a0, a1) = (CGRect(), CGRect())
    getParagraphRect(&a0, firstLineRect: &a1, forLineNumber: atLine)

    let attributes = [NSFontAttributeName : lineNumberFont]
    let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
    a0.origin.x += 1.0;
    a0.origin.y += 2.0;
    attributedString.drawAtPoint(a0.origin)
  }

  func zen_annotationAtSidebarPoint(point: CGPoint) -> AnyObject? {
    let annotation = zen_annotationAtSidebarPoint(point)

    if let plugin = plugin {
      if annotation == nil && point.x < CGFloat(sidebarWidth) {
        let line = lineNumberForPoint(point)
        let font = NSFont(name: "Menlo", size: 13.0)!
        let attributes = [NSFontAttributeName : font]
        let attributedString = NSAttributedString(string: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis quis imperdiet nisl. Proin lobortis volutpat massa eu lacinia. Duis faucibus rhoncus efficitur. Donec iaculis lacus et erat eleifend luctus. Nulla ultrices eu magna non placerat. Sed quis eros vel urna tincidunt porttitor. Duis dignissim efficitur cursus.\n\nNunc at erat eget justo facilisis fermentum sit amet sit amet sapien. Vestibulum egestas mi at magna pulvinar commodo. Maecenas eget rutrum mi. Curabitur sollicitudin felis nisi, id pretium tortor eleifend nec. Suspendisse viverra quis diam a aliquam. Mauris in sem fringilla, sollicitudin risus luctus, consectetur diam. Ut a enim non sapien lobortis euismod. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Suspendisse potenti. Duis nibh sapien, viverra id dapibus sed, fermentum eget felis. Phasellus tortor dui, euismod non est et, imperdiet consectetur sem. In hac habitasse platea dictumst. Donec ac ex at ex rhoncus interdum. Mauris magna sapien, aliquam finibus eros sed, pellentesque pulvinar turpis. Quisque eget ante lectus.\n\n Vestibulum consequat ac nisi in sollicitudin. Integer vel ornare ligula. Sed sollicitudin, metus vitae hendrerit facilisis, purus tellus vestibulum eros, id elementum dolor lacus vitae dolor. Suspendisse blandit condimentum lacus, non suscipit metus egestas sit amet. Nunc ac sodales velit. Fusce eget pharetra ante, vitae volutpat libero. Morbi vitae turpis id erat convallis tempus. Donec a lorem ut felis tempor semper. Aenean quam arcu, posuere vitae est non, convallis molestie purus. Curabitur gravida nunc eu feugiat aliquet. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Morbi convallis lobortis velit tempor finibus.", attributes: attributes)
        plugin.socialController.textView.textStorage?.setAttributedString(attributedString)

        var (a0, a1) = (CGRect(), CGRect())
        getParagraphRect(&a0, firstLineRect: &a1, forLineNumber: line)

        plugin.popover.contentSize = CGSize(width: 500, height: 250)
        plugin.socialController.textView.frame.size = plugin.popover.contentSize
        plugin.socialController.textView.frame.origin = CGPoint()
        plugin.popover.showRelativeToRect(a0, ofView: scrollView!, preferredEdge: NSRectEdge.MaxX)
      }
    }

    return annotation
  }

  func zen_drawLineNumbersInSidebarRect(rect: CGRect, foldedIndexes: Int, count: Int, linesToInvert: AnyObject, linesToReplace: AnyObject, getParaRectBlock: AnyObject) {

    lockFocus()

    drawBackground(NSColor(calibratedRed: 244/255, green: 222/255, blue: 202/255, alpha: 1.0), atLine: 60)
    drawText("🚀", atLine: 60)

    unlockFocus()

    self.zen_drawLineNumbersInSidebarRect(rect, foldedIndexes: foldedIndexes, count: count, linesToInvert: linesToInvert, linesToReplace: linesToReplace, getParaRectBlock: getParaRectBlock)
  }

  func zen_sidebarWidth() -> CGFloat {
    return zen_sidebarWidth() + (plugin?.sidebarWidth ?? 0)
  }





}