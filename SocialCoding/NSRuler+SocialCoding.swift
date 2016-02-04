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

        if let social = plugin.data["SocialCoding.swift"] {
          if social.line == line {
            let font = NSFont(name: "Menlo", size: 13.0)!
            let attributedString = NSMutableAttributedString(string: "", attributes: [NSFontAttributeName : font])

            social.comments.forEach {
              attributedString.appendAttributedString(NSAttributedString(string: "\($0.author)\n", attributes: [NSFontAttributeName : NSFont(name: "Menlo Bold", size: 11.0)!]))
              attributedString.appendAttributedString(NSAttributedString(string: "\($0.text)\n\n", attributes: [NSFontAttributeName : font]))
            }

            plugin.socialController.textView.textStorage?.setAttributedString(attributedString)

            var (a0, a1) = (CGRect(), CGRect())
            getParagraphRect(&a0, firstLineRect: &a1, forLineNumber: line)

            plugin.popover.contentSize = CGSize(width: 500, height: 250)
            plugin.socialController.textView.frame.size = plugin.popover.contentSize
            plugin.socialController.textView.frame.origin = CGPoint()
            plugin.popover.showRelativeToRect(a0, ofView: scrollView!, preferredEdge: NSRectEdge.MaxX)
          }
        }
      }
    }

    return annotation
  }

  func zen_drawLineNumbersInSidebarRect(rect: CGRect, foldedIndexes: Int, count: Int, linesToInvert: AnyObject, linesToReplace: AnyObject, getParaRectBlock: AnyObject) {

    if let plugin = plugin {
      lockFocus()
      let line = lineNumberForPoint(rect.origin)
      if let social = plugin.data["SocialCoding.swift"] {
        if social.line == line {
          drawBackground(NSColor(calibratedRed: 244/255, green: 222/255, blue: 202/255, alpha: 1.0), atLine: line)
          drawText("🚀", atLine: line)
        }
      }
      unlockFocus()
    }

    self.zen_drawLineNumbersInSidebarRect(rect, foldedIndexes: foldedIndexes, count: count, linesToInvert: linesToInvert, linesToReplace: linesToReplace, getParaRectBlock: getParaRectBlock)
  }

  func zen_sidebarWidth() -> CGFloat {
    return zen_sidebarWidth() + (plugin?.sidebarWidth ?? 0)
  }
}
