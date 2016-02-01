@import Cocoa;

@interface NSRulerView (SocialCoding)

@property(nonatomic, readonly) NSURL* currentDocumentURL;
@property(nonatomic) BOOL drawsLineNumbers;
@property(retain, nonatomic) NSFont *lineNumberFont;
@property(copy, nonatomic) NSColor *lineNumberTextColor;
@property(assign, nonatomic) double sidebarWidth;

- (void)getParagraphRect:(CGRect *)a0 firstLineRect:(CGRect *)a1 forLineNumber:(NSUInteger)a2;
- (NSUInteger)lineNumberForPoint:(CGPoint)a0;

@end
