

@import <Foundation/CPObject.j>


@implementation Page : CPObject
{
    CPString title @accessors;
}
           
- (id) initWithTitle:(CPString) newtitle {
    self = [super init];
    title = newtitle;
    return self;
}

-(CPString) description {
    return title;
}