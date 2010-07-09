

@import <Foundation/CPObject.j>


@implementation Page : CPObject
{
    CPString title @accessors;
    CPString subtitle @accessors;
    Page[] children @accessors;
    Page ancestor @accessors;
}

+ (Page) initFromJSONObject:(id)object {
    var page = [[Page alloc] initWithTitle:object.title 
                       andSubtitle:object.subtitle];
    return page;
}

- (id) init {
    self = [super init];
    children = [[CPArray alloc] init];
    return self;
}
           
- (id) initWithTitle:(CPString) newtitle 
         andSubtitle:(CPString) newsubtitle {
    self = [self init];
    title = newtitle;
    subtitle = newsubtitle;
    return self;
}
           
- (id) addChild:(Page) child {
    [child setAncestor:self];
    [children addObject:child];
}

- (id) removeChild: (int) index {
    [children removeObjectAtIndex:index];
}

-(CPString) description {
    return title;
}