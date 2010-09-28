@import <Foundation/CPObject.j>
@import "../Page.j"
@implementation PageTest : OJTestCase
{
    Page page;
}

- (void)setup 
{
    self.page = [[Page alloc] initWithTitle:"A Title" andSubtitle:"test12" andType:"test" andNavigationId:"navid"];    
}

- (void)testThatInitializationWorks
{
    self.page = [[Page alloc] initWithTitle:"A Title" andSubtitle:"A Subtitle" andType:"pagetype" andNavigationId:"anavid"];    
    [self assertNotNull:self.page];
    [self assert:page.title equals:"A Title"];
    [self assert:page.subtitle equals:"A Subtitle"];
    [self assert:page.type equals:"pagetype"];
    [self assert:page.navigationId equals:"anavid"];
}

@end