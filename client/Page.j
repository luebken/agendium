

@import <Foundation/CPObject.j>


@implementation Page : CPObject
{
    CPString title @accessors;
    CPString subtitle @accessors;
    Page[] children @accessors;
    Page ancestor @accessors;
    CPString type @accessors;
    CPDictionary attributes @accessors;
}

+ (Page) initFromJSONObject:(id)object {
    var page = [[Page alloc] initWithTitle:object.title 
                               andSubtitle:object.subtitle
                                   andType:object.type];
    for (var i=0; i < object.children.length; i++) {
        var child = [Page initFromJSONObject:object.children[i]];
        [page addChild:child];
    }
    for (var key in object.attributes){
        [[page attributes] setValue:object.attributes[key] forKey:key];
    }
    return page;
}

- (id) init {
    self = [super init];
    children = [[CPArray alloc] init];
    attributes = [CPDictionary dictionary];
    type = "List";
    return self;
}
           
- (id) initWithTitle:(CPString) newtitle 
         andSubtitle:(CPString) newsubtitle
             andType:(CPString) newtype {
    self = [self init];
    title = newtitle;
    subtitle = newsubtitle;
    type = newtype;
    return self;
}
           
- (id) addChild:(Page) child {
    [child setAncestor:self];
    [children addObject:child];
}

- (id) removeChild: (int) index {
    [children removeObjectAtIndex:index];
}

//FIXME OK this looks stupid. How would Objective-J guys do this
- (id) toJSON {
    var childrenJSON = '';
    for (var i=0; i < children.length; i++) {
        childrenJSON += [children[i] toJSON];
        childrenJSON += ',';
    }
    if(childrenJSON.length > 0) {
        childrenJSON = childrenJSON.substring(0, childrenJSON.length - 1);
    }        
    var attributesJSON = '';
    for (var i=0; i < [attributes allKeys].length; i++) {
        var key = [attributes allKeys][i];
        var value = [attributes objectForKey:key];
        attributesJSON += JSON.stringify(key) + ":" +  JSON.stringify(value);
        attributesJSON += ',';
    }
    if(attributesJSON.length > 0) {
        attributesJSON = attributesJSON.substring(0, attributesJSON.length - 1);
    }  

    var json = '{"title":"' + title;
    if(subtitle) {
        json += '","subtitle":"' + subtitle;
    }
    json += '","type":"' + type + '","children":[' + childrenJSON + '],"attributes":{' + attributesJSON + '}}';
    return json;
}

-(CPString) description {
    return title;
}

- (boolean) isListType {
    return type === "List";
}