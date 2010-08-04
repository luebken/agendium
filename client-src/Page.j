

@import <Foundation/CPObject.j>


@implementation Page : CPObject
{
    CPString title @accessors;
    CPString subtitle @accessors;
    Page[] children @accessors;
    CPString type @accessors;
    CPString[] attributes @accessors;
    //transient
    CPString navigationId @accessors;
    Page ancestor @accessors;
}

+ (Page) initFromJSONObject:(id)object andNavigationId:(CPString) navigationId {
    var page = [[Page alloc] initWithTitle:object.title 
                               andSubtitle:object.subtitle
                                   andType:object.type
                           andNavigationId:navigationId];
    for (var i=0; i < object.children.length; i++) {
        var childNnavigationId = navigationId + "c" + i;
        var child = [Page initFromJSONObject:object.children[i] andNavigationId:childNnavigationId];
        [page addChild:child atIndex:-1];
    }
    if(object.attributes){
    for (var i=0; i < object.attributes.length; i++) {
        var attr = object.attributes[i];
        [[page attributes] insertObject:attr atIndex:i];
    }
    }
    return page;
}

//TODO remove
- (id) init {
    self = [super init];
    children = [[CPArray alloc] init];
    attributes = [[CPArray alloc] init];
    type = "Navigation";
    navigationId = "";
    return self;
}
           
- (id) initWithTitle:(CPString) newtitle 
         andSubtitle:(CPString) newsubtitle
             andType:(CPString) newtype
     andNavigationId:(CPString) newNavigationId {
    self = [self init];
    title = newtitle;
    subtitle = newsubtitle;
    type = newtype;
    navigationId = newNavigationId
    return self;
}
           
- (id) addChild:(Page) child atIndex:(int)index {
    [child setAncestor:self];
    if(index < 0) index = children.length;
    [children insertObject:child atIndex:index];
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
    for (var i=0; i < attributes.length; i++) {
        attributesJSON += '{"key":"' + attributes[i].key + '"';
        attributesJSON += ',"value":"' + attributes[i].value + '"}';
        attributesJSON += ',';
    }
    
    if(attributesJSON.length > 0) {
        attributesJSON = attributesJSON.substring(0, attributesJSON.length - 1);
    }  

    var json = '{"title":"' + title;
    if(subtitle) {
        json += '","subtitle":"' + subtitle;
    }
    json += '","type":"' + type + '","children":[' + childrenJSON + '],"attributes":[' + attributesJSON + ']}';
    return json;
}

-(CPString) description {
    return title;
}

- (boolean) isNavigationType {
    return type === "Navigation";
}