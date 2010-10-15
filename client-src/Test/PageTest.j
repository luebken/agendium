@import <Foundation/CPObject.j>
@import "../Page.j"
@implementation PageTest : OJTestCase
{
    Page page;
    Page child1;
}

- (void)setUp 
{
    page = [[Page alloc] 
        initWithTitle:"A Title" 
        andSubtitle:"A Subtitle" 
        andType:"pagetype" 
        andNavigationId:"anavid"];    
        
    child1 = [[Page alloc] 
        initWithTitle:"A ChildTitle" 
        andSubtitle:"A ChildSubtitle" 
        andType:"childpagetype" 
        andNavigationId:"anavid2"];
    child1.attributes[0] = { key:"A key", value:"A value" };
}

- (void)testThatInitializationWorks
{
    [self assertNotNull:page];
    [self assert:page.title equals:"A Title"];
    [self assert:page.subtitle equals:"A Subtitle"];
    [self assert:page.type equals:"pagetype"];
    [self assert:page.navigationId equals:"anavid"];
}

- (void) testDeepCopy 
{
    [page addChild:child1 atIndex:0];
    
    var copy = [page deepCopy];
    [self assert:page.type equals:copy.type];
    [self assert:page.title equals:copy.title];
    [self assert:page.subtitle equals:copy.subtitle];
    [self assert:page.children.length equals:copy.children.length];
    
    [self assert:page.children[0].type equals:copy.children[0].type];
    [self assert:page.children[0].title equals:copy.children[0].title];
    [self assert:page.children[0].subtitle equals:copy.children[0].subtitle];
    [self assert:page.children[0].attributes.length equals:copy.children[0].attributes.length];
    [self assert:copy.children[0].attributes[0].key equals:"A key"];
    [self assert:copy.children[0].attributes[0].value equals:"A value"];
    
}

@end