
@import <Foundation/CPObject.j>

@implementation Page : CPObject
{
    CPString title @accessors;
    CPString subtitle @accessors;
    CPString logourl @accessors;
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
                                andLogourl:object.logourl
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
- (id) init {
    self = [super init];
    [self initWithTitle:''
            andSubtitle:''
            andType:'Navigation'
            andLogourl: ''
            andNavigationId: 'r'];
    return self;
}           

- (id) initWithTitle:(CPString) newtitle 
         andSubtitle:(CPString) newsubtitle
             andType:(CPString) newtype
          andLogourl:(CPString) newlogourl
     andNavigationId:(CPString) newNavigationId {
    self = [super init];
    self.title = newtitle;
    self.subtitle = newsubtitle;
    self.type = newtype;
    self.logourl = newlogourl;
    self.navigationId = newNavigationId;
    self.children = [[CPArray alloc] init];
    self.attributes = [[CPArray alloc] init];
    return self;
}
           
- (BOOL) isRootPage {
    return ancestor == null;
}

- (id) addChild:(Page) child atIndex:(int)index {
    [child setAncestor:self];
    if(index < 0) index = children.length;
    [children insertObject:child atIndex:index];
}

- (id) duplicateChild: (int) index {
    var child = [children objectAtIndex:index];
    var clone = [child deepCopy];
    [self addChild:clone atIndex:index+1];
}

- (id) removeChild: (int) index {
    [children removeObjectAtIndex:index];
}

- (id) deepCopy {
    var copy = [[Page alloc] 
                initWithTitle:self.title
                andSubtitle:self.subtitle
                andType:self.type
                andLogourl:self.logourl
                andNavigationId:self.navigationId];
    for (var i=0; i < children.length; i++) {
        var child = [children[i] deepCopy];
        [copy addChild:child atIndex:i];
    }
    for (var i=0; i < attributes.length; i++) {
        [[copy attributes] insertObject:attributes[i] atIndex:i];
    }
    return copy;
}

- (id) duplicateChild: (int) index {
    var child = [children objectAtIndex:index];
    var clone = [child deepCopy];
    [self addChild:clone atIndex:index+1];
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
    if(logourl) {
        json += '","logourl":"' + logourl;
    }
    json += '","type":"' + type + '","children":[' + childrenJSON + '],"attributes":[' + attributesJSON + ']}';
    return json;
}

-(CPString) description {
    return title;
}

- (BOOL)isEqual:(id)anObject {
  if(![anObject isKindOfClass:[Page class]]) return NO;
  if(anObject.title != self.title) return NO;
  if(anObject.subtitle != self.subtitle) return NO;
  if(anObject.type != self.type) return NO;
  return YES;
  
}

- (boolean) isNavigationType {
    return type === "Navigation";
}