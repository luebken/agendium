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
    var firstdate = new Date(2010, 09-1, 04); 
    var updatedate = new Date(2010, 07-1, 01);    
    var data = [NewTemplate dataonedayonetrack:updatedate withFirstDate:firstdate];
    [self assertNotNull:data];
    var obj = JSON.parse(data);
    [self assert:data notSame:undefined];
    [self assert:obj.rootpage notSame:undefined];
    [self assert:obj.rootpage.type same:'Navigation'];
    
    
    [self assert:obj.rootpage.children[0].subtitle equals:'Update: 01.07.'];
    [self assert:obj.rootpage.children[2].type equals:'Navigation'];
    [self assert:obj.rootpage.children[2].title equals:'Sessions'];
    [self assert:obj.rootpage.children[2].subtitle equals:'04.09.2010'];
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
    [self assert:obj.rootpage.children[0].subtitle equals:'Update: 01.07.'];
    
    [self assert:obj.rootpage.children[2].type equals:'Navigation'];
    [self assert:obj.rootpage.children[2].title equals:'Day 01'];
    [self assert:obj.rootpage.children[2].subtitle equals:'30.09.2010'];
    [self assert:obj.rootpage.children[3].subtitle equals:'01.10.2010'];
    [self assert:obj.rootpage.children[4].subtitle equals:'02.10.2010'];
    
    
}

@end