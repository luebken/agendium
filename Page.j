

@import <Foundation/CPObject.j>


@implementation Page : CPObject
{
    CPString title @accessors;
    CPString subtitle @accessors;

}
           
- (id) initWithTitle:(CPString) newtitle 
         andSubtitle:(CPString) newsubtitle {
    self = [super init];
    title = newtitle;
    subtitle = newsubtitle;
    return self;
}

-(CPString) description {
    return title;
}