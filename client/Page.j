

@import <Foundation/CPObject.j>


@implementation Page : CPObject
{
    CPString title @accessors;
    CPString subtitle @accessors;
    Page[] children @accessors;
    Page ancestor @accessors;
    CPString type @accessors;
}

+ (Page) initFromJSONObject:(id)object {
    var page = [[Page alloc] initWithTitle:object.title 
                       andSubtitle:object.subtitle];
    for (var i=0; i < object.children.length; i++) {
        var child = [Page initFromJSONObject:object.children[i]];
        [page addChild:child];
    }
    return page;
}

- (id) init {
    self = [super init];
    children = [[CPArray alloc] init];
    type = "List";
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

- (id) toJSON {
    var childrenJSON = '';
    for (var i=0; i < children.length; i++) {
        childrenJSON += [children[i] toJSON];
        childrenJSON += ',';
    }
    if(childrenJSON.length > 0) {
        childrenJSON = childrenJSON.substring(0, childrenJSON.length - 1);
    }        
    return '{"title":"' + title + '","subtitle":"' + subtitle + '","children":[' + childrenJSON + ']}';
}

-(CPString) description {
    return title;
}