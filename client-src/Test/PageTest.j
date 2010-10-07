@import <Foundation/CPObject.j>
@import "../Page.j"
@implementation PageTest : OJTestCase
{
    Page page;
}

- (void)setUp 
{
    page = [[Page alloc] initWithTitle:"A Title" andSubtitle:"A Subtitle" andType:"pagetype" andNavigationId:"anavid"];    
}

- (void)testThatInitializationWorks
{
    [self assertNotNull:page];
    [self assert:page.title equals:"A Title"];
    [self assert:page.subtitle equals:"A Subtitle"];
    [self assert:page.type equals:"pagetype"];
    [self assert:page.navigationId equals:"anavid"];
}

@end