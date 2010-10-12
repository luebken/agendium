@import <Foundation/CPObject.j>
@import "../NewTemplate.j"
@implementation NewTemplateTest : OJTestCase
{
}

- (void)setUp 
{
    CPLogRegister(CPLogPrint);
}

- (void)testOnedayOneTrack
{
    var firstdate = new Date(2010, 09-1, 05); 
    var updatedate = new Date(2010, 07-1, 01);    
    var data = [NewTemplate dataonedayonetrack:updatedate withFirstDate:firstdate];
    [self assertNotNull:data];
    var obj = JSON.parse(data);
    [self assert:data notSame:undefined];
    [self assert:obj.rootpage notSame:undefined];
    [self assert:obj.rootpage.type same:'Navigation'];
    
    
    [self assert:obj.rootpage.children[0].subtitle equals:'Update: 01. Jul.'];
    [self assert:obj.rootpage.children[2].type equals:'Navigation'];
    [self assert:obj.rootpage.children[2].title equals:'Sessions'];
    [self assert:obj.rootpage.children[2].subtitle equals:'Sun, 05 Sep 2010'];
}
- (void)testThreedaysTwotracks
{
    var date = new Date(2010, 09-1, 30); 
    var updatedate = new Date(2010, 07-1, 01);       
    var data = [NewTemplate datathreedaystwotracks:updatedate withFirstDate:date];
    [self assertNotNull:data];
    var obj = JSON.parse(data);
    [self assert:data notSame:undefined];
    [self assert:obj.rootpage notSame:undefined];
    [self assert:obj.rootpage.type same:'Navigation'];
    [self assert:obj.rootpage.children[0].subtitle equals:'Update: 01. Jul.'];
    
    [self assert:obj.rootpage.children[2].type equals:'Navigation'];
    [self assert:obj.rootpage.children[2].title equals:'Day 01'];
    [self assert:obj.rootpage.children[2].subtitle equals:'Thu, 30 Sep 2010'];
    [self assert:obj.rootpage.children[3].subtitle equals:'Fri, 01 Oct 2010'];
    [self assert:obj.rootpage.children[4].subtitle equals:'Sat, 02 Oct 2010'];
}

@end