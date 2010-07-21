@STATIC;1.0;p;15;AppController.jt;7755;@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;10;PageView.ji;20;PageViewController.jt;7660;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("Page.j", YES);
objj_executeFile("PageView.j", YES);
objj_executeFile("PageViewController.j", YES);
{var the_class = objj_allocateClassPair(CPObject, "AppController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("theWindow"), new objj_ivar("box"), new objj_ivar("saveButton"), new objj_ivar("loadButton"), new objj_ivar("previewButton"), new objj_ivar("rootPage"), new objj_ivar("titleLabel"), new objj_ivar("appnameField"), new objj_ivar("pageView"), new objj_ivar("pageViewController"), new objj_ivar("baseURL"), new objj_ivar("appId"), new objj_ivar("listConnection"), new objj_ivar("saveConnection")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("applicationDidFinishLaunching:"), function $AppController__applicationDidFinishLaunching_(self, _cmd, aNotification)
{ with(self)
{
}
},["void","CPNotification"]), new objj_method(sel_getUid("resetData"), function $AppController__resetData(self, _cmd)
{ with(self)
{
    rootPage = objj_msgSend(objj_msgSend(Page, "alloc"), "init");
    objj_msgSend(rootPage, "setTitle:", objj_msgSend(appnameField, "objectValue"));
    pageViewController.page = rootPage;
    appId = null;
}
},["void"]), new objj_method(sel_getUid("awakeFromCib"), function $AppController__awakeFromCib(self, _cmd)
{ with(self)
{
    objj_msgSend(titleLabel, "setFont:", objj_msgSend(CPFont, "boldSystemFontOfSize:", 24.0));
    baseURL = "http://localhost:3000/";
    objj_msgSend(box, "setBorderType:", CPLineBorder);
    objj_msgSend(box, "setBorderWidth:", 1);
    objj_msgSend(box, "setBorderColor:", objj_msgSend(CPColor, "grayColor"));
    pageViewController = objj_msgSend(objj_msgSend(PageViewController, "alloc"), "initWithCibName:bundle:", "PageView", nil);
    objj_msgSend(pageViewController, "setPage:", rootPage);
    objj_msgSend(objj_msgSend(pageViewController, "view"), "setFrame:", CPRectMake( 1 , 1, 500, 395))
    objj_msgSend(pageView, "addSubview:", objj_msgSend(pageViewController, "view"));
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("pageDidChange:"), "PageChangedNotification", rootPage);
    objj_msgSend(previewButton, "setBordered:", NO);
    previewButton._DOMElement.style.textDecoration = "underline";
    objj_msgSend(previewButton, "setTextColor:", objj_msgSend(CPColor, "blueColor"));
    objj_msgSend(previewButton, "setTarget:", self);
    objj_msgSend(previewButton, "setAction:", sel_getUid("setWindowLocation"));
    previewButton._DOMElement.style.cursor = "pointer";
    objj_msgSend(self, "resetData");
    objj_msgSend(rootPage, "setTitle:", "FOWA2010")
    objj_msgSend(appnameField, "setObjectValue:", "FOWA2010");
    objj_msgSend(self, "myRefresh")
}
},["void"]), new objj_method(sel_getUid("setWindowLocation"), function $AppController__setWindowLocation(self, _cmd)
{ with(self)
{
    var applink = baseURL + "a/" + appId;
    window.location = applink;
}
},["void"]), new objj_method(sel_getUid("pageDidChange:"), function $AppController__pageDidChange_(self, _cmd, notification)
{ with(self)
{
    objj_msgSend(saveButton, "setEnabled:", rootPage.title.length > 0);
}
},["void","CPNotification"]), new objj_method(sel_getUid("controlTextDidChange:"), function $AppController__controlTextDidChange_(self, _cmd, sender)
{ with(self)
{
    var length = objj_msgSend(objj_msgSend(appnameField, "objectValue"), "length");
    objj_msgSend(rootPage, "setTitle:", objj_msgSend(appnameField, "objectValue"));
    objj_msgSend(self, "myRefresh");
}
},["void","id"]), new objj_method(sel_getUid("myRefresh"), function $AppController__myRefresh(self, _cmd)
{ with(self)
{
    var enable = rootPage.title.length > 0;
    objj_msgSend(saveButton, "setEnabled:", enable);
    objj_msgSend(loadButton, "setEnabled:", enable);
    objj_msgSend(pageViewController, "myRefresh");
    var applink = baseURL + "a/" + appId;
    if(appId){
        objj_msgSend(previewButton, "setTitle:", applink);
    } else {
        objj_msgSend(previewButton, "setTitle:", "");
    }
}
},["void"]), new objj_method(sel_getUid("load:"), function $AppController__load_(self, _cmd, sender)
{ with(self)
{
    console.log("loading...");
    var request = objj_msgSend(CPURLRequest, "requestWithURL:", baseURL+"agenda/"+rootPage.title);
    objj_msgSend(request, "setHTTPMethod:", 'GET');
    listConnection = objj_msgSend(CPURLConnection, "connectionWithRequest:delegate:", request, self);
}
},["@action","id"]), new objj_method(sel_getUid("new:"), function $AppController__new_(self, _cmd, sender)
{ with(self)
{
    console.log("new");
    objj_msgSend(appnameField, "setObjectValue:", "");
    objj_msgSend(self, "resetData");
    objj_msgSend(self, "myRefresh");
}
},["@action","id"]), new objj_method(sel_getUid("save:"), function $AppController__save_(self, _cmd, sender)
{ with(self)
{
    var request = objj_msgSend(CPURLRequest, "requestWithURL:", baseURL + "agenda");
    objj_msgSend(request, "setHTTPMethod:", 'POST');
    var jsonData = '{"_id":"' + appId + '", "rootpage":'+ objj_msgSend(rootPage, "toJSON") + '}';
    console.log("Saving JSON: " + jsonData);
    objj_msgSend(request, "setHTTPBody:", jsonData);
    objj_msgSend(request, "setValue:forHTTPHeaderField:", 'application/json', "Accept");
    objj_msgSend(request, "setValue:forHTTPHeaderField:", 'application/json', "Content-Type");
    saveConnection = objj_msgSend(CPURLConnection, "connectionWithRequest:delegate:", request, self);
}
},["@action","id"]), new objj_method(sel_getUid("connection:didReceiveData:"), function $AppController__connection_didReceiveData_(self, _cmd, connection, data)
{ with(self)
{
    console.log("didReceiveData: '" + data + "'");
    if(connection == saveConnection) {
        var alert = objj_msgSend(objj_msgSend(CPAlert, "alloc"), "init");
        var theme = objj_msgSend(CPTheme, "themeNamed:", "Aristo-HUD");
        objj_msgSend(alert, "setWindowStyle:", CPHUDBackgroundWindowMask);
        objj_msgSend(alert, "setAlertStyle:", CPInformationalAlertStyle);
        objj_msgSend(alert, "setMessageText:", "Saved!");
        objj_msgSend(alert, "addButtonWithTitle:", "OK");
        objj_msgSend(alert, "runModal");
    }
    if(data != '') {
        objj_msgSend(self, "didReceiveLoadData:", data);
    } else {
        alert('Couldn\'t find Agenda: "' + rootPage.title + '"');
        objj_msgSend(self, "resetData");
        objj_msgSend(self, "myRefresh")
    }
}
},["void","CPURLConnection","CPString"]), new objj_method(sel_getUid("didReceiveLoadData:"), function $AppController__didReceiveLoadData_(self, _cmd, data)
{ with(self)
{
    try {
        var obj = JSON.parse(data);
        var rootPage = objj_msgSend(Page, "initFromJSONObject:", obj.rootpage);
        self.appId = obj._id;
        objj_msgSend(pageViewController, "setPage:", rootPage);
        objj_msgSend(self, "myRefresh");
    } catch (e) {
        console.log("Error in didReceiveData. " + e);
        alert(e);
    }
}
},["void","CPString"]), new objj_method(sel_getUid("connection:didFailWithError:"), function $AppController__connection_didFailWithError_(self, _cmd, connection, error)
{ with(self)
{
    console.log("didFailWithError: " + error);
    alert(error);
}
},["void","CPURLConnection","id"]), new objj_method(sel_getUid("connection:didReceiveResponse:"), function $AppController__connection_didReceiveResponse_(self, _cmd, connection, response)
{ with(self)
{
    console.log("didReceiveResponse for URL:" + objj_msgSend(response, "URL"));
}
},["void","CPURLConnection","CPHTTPURLResponse"])]);
}

p;18;ButtonColumnView.jt;2260;@STATIC;1.0;I;15;AppKit/CPView.jt;2221;


objj_executeFile("AppKit/CPView.j", NO);


{var the_class = objj_allocateClassPair(CPView, "ButtonColumnView"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("button"), new objj_ivar("row"), new objj_ivar("delegate")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:andDelegate:"), function $ButtonColumnView__initWithFrame_andDelegate_(self, _cmd, rect, delegate2)
{ with(self)
{
        self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ButtonColumnView").super_class }, "initWithFrame:", rect);
        button = objj_msgSend(CPButton, "buttonWithTitle:", ">");
        objj_msgSend(button, "setCenter:", CPPointMake(10, 25));

        objj_msgSend(self, "addSubview:", button);
        objj_msgSend(button, "setTarget:", self);
        objj_msgSend(button, "setAction:", sel_getUid("rowSelected:"));
        self.delegate = delegate2;
        return self;
}
},["id","CGRect","id"]), new objj_method(sel_getUid("setObjectValue:"), function $ButtonColumnView__setObjectValue_(self, _cmd, anObject)
{ with(self)
{
    row = anObject;
    objj_msgSend(button, "setTitle:", ">");
}
},["void","Object"]), new objj_method(sel_getUid("initWithCoder:"), function $ButtonColumnView__initWithCoder_(self, _cmd, aCoder)
{ with(self)
{
        self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ButtonColumnView").super_class }, "initWithCoder:", aCoder);
        button = objj_msgSend(aCoder, "decodeObjectForKey:", "button");
        return self;
}
},["id","CPCoder"]), new objj_method(sel_getUid("encodeWithCoder:"), function $ButtonColumnView__encodeWithCoder_(self, _cmd, aCoder)
{ with(self)
{
        objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ButtonColumnView").super_class }, "encodeWithCoder:", aCoder);
        objj_msgSend(aCoder, "encodeObject:forKey:", button, "button");
}
},["void","CPCoder"]), new objj_method(sel_getUid("rowSelected:"), function $ButtonColumnView__rowSelected_(self, _cmd, sender)
{ with(self)
{
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "postNotificationName:object:", "RowClickedNotification", row);
}
},["void","id"])]);
}

p;21;CPPropertyAnimation.jt;8477;@STATIC;1.0;I;20;AppKit/CPAnimation.jt;8433;objj_executeFile("AppKit/CPAnimation.j", NO);
{var the_class = objj_allocateClassPair(CPAnimation, "CPPropertyAnimation"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("view"), new objj_ivar("properties"), new objj_ivar("_startView"), new objj_ivar("_endView"), new objj_ivar("_startFrame"), new objj_ivar("_finalDelegate"), new objj_ivar("direction")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("direction"), function $CPPropertyAnimation__direction(self, _cmd)
{ with(self)
{
return direction;
}
},["id"]),
new objj_method(sel_getUid("setDirection:"), function $CPPropertyAnimation__setDirection_(self, _cmd, newValue)
{ with(self)
{
direction = newValue;
}
},["void","id"]), new objj_method(sel_getUid("initWithView:"), function $CPPropertyAnimation__initWithView_(self, _cmd, aView)
{ with(self)
{
 self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CPPropertyAnimation").super_class }, "initWithDuration:animationCurve:", 0.4, CPAnimationEaseOut);
 if (self)
 {
  view = aView;
        _startFrame = CGRectMakeCopy(objj_msgSend(aView, "frame"));
  properties = objj_msgSend(CPDictionary, "dictionary");
 }
 return self;
}
},["id","CPView"]), new objj_method(sel_getUid("animationDidEnd:"), function $CPPropertyAnimation__animationDidEnd_(self, _cmd, animation)
{ with(self)
{
        var rect;
        if(animation.direction === 'left'){
        rect = CGRectMake(_startFrame.origin.x + _startFrame.size.width,
                                 _startFrame.origin.y,
                                 _startFrame.size.width,
                                 _startFrame.size.height);
        } else {
        rect = CGRectMake(_startFrame.origin.x - _startFrame.size.width,
                                 _startFrame.origin.y,
                                 _startFrame.size.width,
                                 _startFrame.size.height);
        }
        var inAnimation = objj_msgSend(objj_msgSend(CPPropertyAnimation, "alloc"), "initWithView:", view);
        objj_msgSend(inAnimation, "setDelegate:", _finalDelegate);
        objj_msgSend(inAnimation, "addProperty:start:end:", "frame", rect, _startFrame);
        objj_msgSend(inAnimation, "startAnimation");
}
},["void","CPAnimation"]), new objj_method(sel_getUid("view"), function $CPPropertyAnimation__view(self, _cmd)
{ with(self)
{
 return view;
}
},["CPView"]), new objj_method(sel_getUid("addProperty:start:end:"), function $CPPropertyAnimation__addProperty_start_end_(self, _cmd, aPath, aStart, anEnd)
{ with(self)
{
 if (!objj_msgSend(view, "respondsToSelector:", aPath))
  return;
 objj_msgSend(properties, "setObject:forKey:", {start: aStart, end:anEnd}, aPath);
 objj_msgSend(view, "setValue:forKey:", aStart, aPath);
}
},["void","CPString","CPValue","CPValue"]), new objj_method(sel_getUid("addToViewOnStart:"), function $CPPropertyAnimation__addToViewOnStart_(self, _cmd, aView)
{ with(self)
{
 _startView = aView;
}
},["void","CPView"]), new objj_method(sel_getUid("willAddToViewOnStart"), function $CPPropertyAnimation__willAddToViewOnStart(self, _cmd)
{ with(self)
{
 return _startView;
}
},["CPView"]), new objj_method(sel_getUid("removeFromSuperviewOnEnd:"), function $CPPropertyAnimation__removeFromSuperviewOnEnd_(self, _cmd, aFlag)
{ with(self)
{
 _endView = aFlag;
}
},["void","BOOL"]), new objj_method(sel_getUid("willRemoveFromSuperviewOnEnd"), function $CPPropertyAnimation__willRemoveFromSuperviewOnEnd(self, _cmd)
{ with(self)
{
 return _endView;
}
},["BOOL"]), new objj_method(sel_getUid("setCurrentProgress:"), function $CPPropertyAnimation__setCurrentProgress_(self, _cmd, progress)
{ with(self)
{
 objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CPPropertyAnimation").super_class }, "setCurrentProgress:", progress);
 var progress = objj_msgSend(self, "currentValue");
 var keys = objj_msgSend(properties, "allKeys"),
  count = objj_msgSend(keys, "count");
 for (var i = 0; i < count; i++)
 {
  var keyPath = keys[i],
   property = objj_msgSend(properties, "objectForKey:", keyPath);
  if (!property)
   continue;
  var start = property.start,
   end = property.end,
   value;
  if (keyPath == 'width' || keyPath == 'height')
   value = (progress * (end - start)) + start;
  else if (keyPath == 'size')
   value = CGSizeMake((progress * (end.width - start.width)) + start.width, (progress * (end.height - start.height)) + start.height);
  else if (keyPath == 'frame')
  {
   value = CGRectMake(
    (progress * (end.origin.x - start.origin.x)) + start.origin.x,
    (progress * (end.origin.y - start.origin.y)) + start.origin.y,
    (progress * (end.size.width - start.size.width)) + start.size.width,
    (progress * (end.size.height - start.size.height)) + start.size.height);
  }
  else if (keyPath == 'alphaValue')
   value = (progress * (end - start)) + start;
  else if (keyPath == 'backgroundColor' || keyPath == 'textColor' || keyPath == 'textShadowColor')
  {
      var red = (progress * (objj_msgSend(end, "redComponent") - objj_msgSend(start, "redComponent"))) + objj_msgSend(start, "redComponent"),
          green = (progress * (objj_msgSend(end, "greenComponent") - objj_msgSend(start, "greenComponent"))) + objj_msgSend(start, "greenComponent"),
          blue = (progress * (objj_msgSend(end, "blueComponent") - objj_msgSend(start, "blueComponent"))) + objj_msgSend(start, "blueComponent"),
          alpha = (progress * (objj_msgSend(end, "alphaComponent") - objj_msgSend(start, "alphaComponent"))) + objj_msgSend(start, "alphaComponent");
      value = objj_msgSend(CPColor, "colorWithCalibratedRed:green:blue:alpha:", red, green, blue, alpha);
  }
  objj_msgSend(view, "setValue:forKey:", value, keyPath);
 }
}
},["void","float"]), new objj_method(sel_getUid("startAnimation"), function $CPPropertyAnimation__startAnimation(self, _cmd)
{ with(self)
{
 var count = objj_msgSend(properties, "count");
 for (var i = 0; i < count; i++)
 {
  var keyPath = objj_msgSend(properties, "allKeys")[i],
   property = objj_msgSend(properties, "objectForKey:", keyPath);
  if (!property)
   continue;
  objj_msgSend(view, "setValue:forKey:", property.start, keyPath);
 }
 if (_startView)
  objj_msgSend(_startView, "addSubview:", view);
 objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CPPropertyAnimation").super_class }, "startAnimation");
}
},["void"]), new objj_method(sel_getUid("animationTimerDidFire:"), function $CPPropertyAnimation__animationTimerDidFire_(self, _cmd, aTimer)
{ with(self)
{
    objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CPPropertyAnimation").super_class }, "animationTimerDidFire:", aTimer);
 if (_progress === 1.0 && _endView)
  objj_msgSend(view, "removeFromSuperview");
}
},["void","CPTimer"])]);
class_addMethods(meta_class, [new objj_method(sel_getUid("slideLeft:view:"), function $CPPropertyAnimation__slideLeft_view_(self, _cmd, delegate, view)
{ with(self)
{
        var frame = objj_msgSend(view, "frame");
        var offLeft = CGRectMake(frame.origin.x - frame.size.width,
                                 frame.origin.y,
                                 frame.size.width,
                                 frame.size.height);
        var outAnimation = objj_msgSend(objj_msgSend(CPPropertyAnimation, "alloc"), "initWithView:", view);
        outAnimation.direction = "left";
        objj_msgSend(outAnimation, "setDelegate:", outAnimation);
        objj_msgSend(outAnimation, "addProperty:start:end:", "frame", frame, offLeft);
        _finalDelegate = delegate;
        return outAnimation;
}
},["CPPropertyAnimation","id","id"]), new objj_method(sel_getUid("slideRight:view:"), function $CPPropertyAnimation__slideRight_view_(self, _cmd, delegate, view)
{ with(self)
{
        var frame = objj_msgSend(view, "frame");
        var offRight = CGRectMake(frame.origin.x + frame.size.width,
                                 frame.origin.y,
                                 frame.size.width,
                                 frame.size.height);
        var outAnimation = objj_msgSend(objj_msgSend(CPPropertyAnimation, "alloc"), "initWithView:", view);
        outAnimation.direction = "right";
        objj_msgSend(outAnimation, "setDelegate:", outAnimation);
        objj_msgSend(outAnimation, "addProperty:start:end:", "frame", frame, offRight);
        _finalDelegate = delegate;
        return outAnimation;
}
},["CPPropertyAnimation","id","id"])]);
}

p;6;main.jt;295;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jt;209;objj_executeFile("Foundation/Foundation.j", NO);
objj_executeFile("AppKit/AppKit.j", NO);
objj_executeFile("AppController.j", YES);
main= function(args, namedArgs)
{
    CPApplicationMain(args, namedArgs);
}

p;6;Page.jt;5196;@STATIC;1.0;I;21;Foundation/CPObject.jt;5151;



objj_executeFile("Foundation/CPObject.j", NO);


{var the_class = objj_allocateClassPair(CPObject, "Page"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("title"), new objj_ivar("subtitle"), new objj_ivar("children"), new objj_ivar("ancestor"), new objj_ivar("type"), new objj_ivar("attributes")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("title"), function $Page__title(self, _cmd)
{ with(self)
{
return title;
}
},["id"]),
new objj_method(sel_getUid("setTitle:"), function $Page__setTitle_(self, _cmd, newValue)
{ with(self)
{
title = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("subtitle"), function $Page__subtitle(self, _cmd)
{ with(self)
{
return subtitle;
}
},["id"]),
new objj_method(sel_getUid("setSubtitle:"), function $Page__setSubtitle_(self, _cmd, newValue)
{ with(self)
{
subtitle = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("children"), function $Page__children(self, _cmd)
{ with(self)
{
return children;
}
},["id"]),
new objj_method(sel_getUid("setChildren:"), function $Page__setChildren_(self, _cmd, newValue)
{ with(self)
{
children = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("ancestor"), function $Page__ancestor(self, _cmd)
{ with(self)
{
return ancestor;
}
},["id"]),
new objj_method(sel_getUid("setAncestor:"), function $Page__setAncestor_(self, _cmd, newValue)
{ with(self)
{
ancestor = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("type"), function $Page__type(self, _cmd)
{ with(self)
{
return type;
}
},["id"]),
new objj_method(sel_getUid("setType:"), function $Page__setType_(self, _cmd, newValue)
{ with(self)
{
type = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("attributes"), function $Page__attributes(self, _cmd)
{ with(self)
{
return attributes;
}
},["id"]),
new objj_method(sel_getUid("setAttributes:"), function $Page__setAttributes_(self, _cmd, newValue)
{ with(self)
{
attributes = newValue;
}
},["void","id"]), new objj_method(sel_getUid("init"), function $Page__init(self, _cmd)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("Page").super_class }, "init");
    children = objj_msgSend(objj_msgSend(CPArray, "alloc"), "init");
    attributes = objj_msgSend(CPDictionary, "dictionary");
    type = "List";
    return self;
}
},["id"]), new objj_method(sel_getUid("initWithTitle:andSubtitle:andType:"), function $Page__initWithTitle_andSubtitle_andType_(self, _cmd, newtitle, newsubtitle, newtype)
{ with(self)
{
    self = objj_msgSend(self, "init");
    title = newtitle;
    subtitle = newsubtitle;
    type = newtype;
    return self;
}
},["id","CPString","CPString","CPString"]), new objj_method(sel_getUid("addChild:"), function $Page__addChild_(self, _cmd, child)
{ with(self)
{
    objj_msgSend(child, "setAncestor:", self);
    objj_msgSend(children, "addObject:", child);
}
},["id","Page"]), new objj_method(sel_getUid("removeChild:"), function $Page__removeChild_(self, _cmd, index)
{ with(self)
{
    objj_msgSend(children, "removeObjectAtIndex:", index);
}
},["id","int"]), new objj_method(sel_getUid("toJSON"), function $Page__toJSON(self, _cmd)
{ with(self)
{
    var childrenJSON = '';
    for (var i=0; i < children.length; i++) {
        childrenJSON += objj_msgSend(children[i], "toJSON");
        childrenJSON += ',';
    }
    if(childrenJSON.length > 0) {
        childrenJSON = childrenJSON.substring(0, childrenJSON.length - 1);
    }
    var attributesJSON = '';
    for (var i=0; i < objj_msgSend(attributes, "allKeys").length; i++) {
        var key = objj_msgSend(attributes, "allKeys")[i];
        var value = objj_msgSend(attributes, "objectForKey:", key);
        attributesJSON += JSON.stringify(key) + ":" + JSON.stringify(value);
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
},["id"]), new objj_method(sel_getUid("description"), function $Page__description(self, _cmd)
{ with(self)
{
    return title;
}
},["CPString"]), new objj_method(sel_getUid("isListType"), function $Page__isListType(self, _cmd)
{ with(self)
{
    return type === "List";
}
},["boolean"])]);
class_addMethods(meta_class, [new objj_method(sel_getUid("initFromJSONObject:"), function $Page__initFromJSONObject_(self, _cmd, object)
{ with(self)
{
    var page = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:andType:", object.title, object.subtitle, object.type);
    for (var i=0; i < object.children.length; i++) {
        var child = objj_msgSend(Page, "initFromJSONObject:", object.children[i]);
        objj_msgSend(page, "addChild:", child);
    }
    for (var key in object.attributes){
        objj_msgSend(objj_msgSend(page, "attributes"), "setValue:forKey:", object.attributes[key], key);
    }
    return page;
}
},["Page","id"])]);
}p;10;PageView.jt;583;@STATIC;1.0;I;15;AppKit/CPView.jt;545;


objj_executeFile("AppKit/CPView.j", NO);


{var the_class = objj_allocateClassPair(CPView, "PageView"),
meta_class = the_class.isa;objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $PageView__initWithFrame_(self, _cmd, aRect)
{ with(self)
{
    if (self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("PageView").super_class }, "initWithFrame:", aRect))
    {
        console.log('PageView.initWithFrame');
    }
    return self;
}
},["id","CGRect"])]);
}

p;20;PageViewController.jt;12218;@STATIC;1.0;I;21;Foundation/CPObject.ji;18;ButtonColumnView.ji;21;CPPropertyAnimation.jt;12123;


objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("ButtonColumnView.j", YES);
objj_executeFile("CPPropertyAnimation.j", YES);


{var the_class = objj_allocateClassPair(CPViewController, "PageViewController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("scrollView"), new objj_ivar("page"), new objj_ivar("deleteButton"), new objj_ivar("addButton"), new objj_ivar("backButton"), new objj_ivar("editButton"), new objj_ivar("pagetypeButton"), new objj_ivar("table"), new objj_ivar("titleField"), new objj_ivar("itemsLabel"), new objj_ivar("editing")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("page"), function $PageViewController__page(self, _cmd)
{ with(self)
{
return page;
}
},["id"]),
new objj_method(sel_getUid("setPage:"), function $PageViewController__setPage_(self, _cmd, newValue)
{ with(self)
{
page = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("editing"), function $PageViewController__editing(self, _cmd)
{ with(self)
{
return editing;
}
},["id"]),
new objj_method(sel_getUid("setEditing:"), function $PageViewController__setEditing_(self, _cmd, newValue)
{ with(self)
{
editing = newValue;
}
},["void","id"]), new objj_method(sel_getUid("initWithCibName:bundle:"), function $PageViewController__initWithCibName_bundle_(self, _cmd, aCibNameOrNil, aCibBundleOrNil)
{ with(self)
{
    if (self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("PageViewController").super_class }, "initWithCibName:bundle:", aCibNameOrNil, aCibBundleOrNil))
    {


    }
    return self;
}
},["id","CPString","CPBundle"]), new objj_method(sel_getUid("awakeFromCib"), function $PageViewController__awakeFromCib(self, _cmd)
{ with(self)
{
    table = objj_msgSend(objj_msgSend(CPTableView, "alloc"), "initWithFrame:", CGRectMake(0.0, 0.0, 200.0, 600.0));

    var column1 = objj_msgSend(objj_msgSend(CPTableColumn, "alloc"), "initWithIdentifier:", "first");
    objj_msgSend(objj_msgSend(column1, "headerView"), "setStringValue:", "Title");
    objj_msgSend(column1, "setWidth:", 200.0);
    objj_msgSend(column1, "setEditable:", YES);
    objj_msgSend(table, "addTableColumn:", column1);

    var column2 = objj_msgSend(objj_msgSend(CPTableColumn, "alloc"), "initWithIdentifier:", "second");
    objj_msgSend(objj_msgSend(column2, "headerView"), "setStringValue:", "Subtitle");
    objj_msgSend(column2, "setWidth:", 260.0);
    objj_msgSend(column2, "setEditable:", YES);
    objj_msgSend(table, "addTableColumn:", column2);

    var button = objj_msgSend(objj_msgSend(ButtonColumnView, "alloc"), "initWithFrame:andDelegate:", CGRectMake(0.0, 0.0, 10.0, 20.0), self);
    var column3 = objj_msgSend(objj_msgSend(CPTableColumn, "alloc"), "initWithIdentifier:", "button");
    objj_msgSend(column3, "setDataView:", button);
    objj_msgSend(column3, "setWidth:", 20.0);
    objj_msgSend(column3, "setEditable:", YES);
    objj_msgSend(table, "addTableColumn:", column3);

    objj_msgSend(table, "setUsesAlternatingRowBackgroundColors:", YES);
    objj_msgSend(table, "setRowHeight:", 50);
    objj_msgSend(table, "setDataSource:", self);
    objj_msgSend(table, "setDelegate:", self);
    objj_msgSend(table, "setAllowsColumnSelection:", NO);

    objj_msgSend(scrollView, "setDocumentView:", table);

    objj_msgSend(deleteButton, "setEnabled:", NO);
    objj_msgSend(backButton, "setEnabled:", NO);
    objj_msgSend(pagetypeButton, "removeAllItems");
    objj_msgSend(pagetypeButton, "addItemsWithTitles:",  ['List', 'Detail']);

    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("tableViewSelectionDidChange:"), CPTableViewSelectionDidChangeNotification, nil);

    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("rowClicked:"), "RowClickedNotification", nil);
}
},["void"]), new objj_method(sel_getUid("tableView:shouldEditTableColumn:row:"), function $PageViewController__tableView_shouldEditTableColumn_row_(self, _cmd, aTableView, tableColumn, row)
{ with(self)
{
    objj_msgSend(self, "setEditing:", NO);
    objj_msgSend(self, "toggleEditing:", aTableView);
    return YES;
}
},["BOOL","CPTableView","CPTableColumn","int"]), new objj_method(sel_getUid("toggleEditing:"), function $PageViewController__toggleEditing_(self, _cmd, sender)
{ with(self)
{
    var field;
    if(self.editing) {
        field = objj_msgSend(CPTextField, "labelWithTitle:", "");



        objj_msgSend(field, "setVerticalAlignment:", CPCenterTextAlignment);



        objj_msgSend(self, "setEditing:", NO);
        objj_msgSend(editButton, "setTitle:", "Edit");
        objj_msgSend(editButton, "unsetThemeState:", CPThemeStateDefault);

    } else {
        field = objj_msgSend(CPTextField, "textFieldWithStringValue:placeholder:width:", "", "", 100);
        objj_msgSend(self, "setEditing:", YES);
        objj_msgSend(editButton, "setTitle:", "Done");
        objj_msgSend(editButton, "setThemeState:", CPThemeStateDefault);
    }
    var cols = objj_msgSend(table, "tableColumns");
    objj_msgSend(cols[0], "setDataView:", field);
    objj_msgSend(cols[1], "setDataView:", field);
    objj_msgSend(self, "myRefresh");

}
},["@action","id"]), new objj_method(sel_getUid("numberOfRowsInTableView:"), function $PageViewController__numberOfRowsInTableView_(self, _cmd, tableView)
{ with(self)
{
    if(objj_msgSend(page, "isListType")) {
        return objj_msgSend(objj_msgSend(page, "children"), "count");
    } else {
        return objj_msgSend(objj_msgSend(objj_msgSend(page, "attributes"), "allKeys"), "count");
    }
}
},["int","CPTableView"]), new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"), function $PageViewController__tableView_objectValueForTableColumn_row_(self, _cmd, tableView, tableColumn, row)
{ with(self)
{
    if(objj_msgSend(page, "isListType")) {
        var pageAtRow = objj_msgSend(objj_msgSend(page, "children"), "objectAtIndex:", row);
        if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "first")) {
            return objj_msgSend(pageAtRow, "title");
        } else if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "second")) {
            return objj_msgSend(pageAtRow, "subtitle");
        } else {
            return row + "";
        }
    } else {
        var key = objj_msgSend(objj_msgSend(page, "attributes"), "allKeys")[row];
        var value = objj_msgSend(objj_msgSend(page, "attributes"), "objectForKey:", key);
        if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "first")) {
            return key;
        } else if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "second")) {
            return value;
        }
    }
}
},["id","CPTableView","CPTableColumn","int"]), new objj_method(sel_getUid("tableView:setObjectValue:forTableColumn:row:"), function $PageViewController__tableView_setObjectValue_forTableColumn_row_(self, _cmd, aTableView, aValue, tableColumn, row)
{ with(self)
{
    if(objj_msgSend(page, "isListType")) {
        var pageAtRow = objj_msgSend(objj_msgSend(page, "children"), "objectAtIndex:", row);
        if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "first")) {
            objj_msgSend(pageAtRow, "setTitle:", aValue);
        } else {
            objj_msgSend(pageAtRow, "setSubtitle:", aValue);
        }
    } else {
        var col0 = objj_msgSend(table, "tableColumns")[0];
        var col1 = objj_msgSend(table, "tableColumns")[1]
        var oldAttributeKey = objj_msgSend(self, "tableView:objectValueForTableColumn:row:", table, col0, row);
        var oldValue = objj_msgSend(self, "tableView:objectValueForTableColumn:row:", table, col1, row);
        if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "first")) {
            objj_msgSend(objj_msgSend(page, "attributes"), "removeObjectForKey:", oldAttributeKey);
            objj_msgSend(objj_msgSend(page, "attributes"), "setValue:forKey:", oldValue, aValue);
        } else {
            objj_msgSend(objj_msgSend(page, "attributes"), "setValue:forKey:", aValue, oldAttributeKey);
        }
    }




}
},["void","CPTableView","id","CPTableColumn","int"]), new objj_method(sel_getUid("tableViewSelectionDidChange:"), function $PageViewController__tableViewSelectionDidChange_(self, _cmd, notification)
{ with(self)
{
    var chosenRow = objj_msgSend(objj_msgSend(table, "selectedRowIndexes"), "firstIndex");
    objj_msgSend(deleteButton, "setEnabled:", chosenRow > -1)
}
},["void","CPNotification"]), new objj_method(sel_getUid("addItemToList:"), function $PageViewController__addItemToList_(self, _cmd, sender)
{ with(self)
{
    if(objj_msgSend(page, "isListType")) {
        var newpage = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:andType:", "A title", "A subtitle",  "List");
        objj_msgSend(page, "addChild:", newpage);
    } else {
        objj_msgSend(objj_msgSend(page, "attributes"), "setValue:forKey:", "A value", "A attribute");
    }
    objj_msgSend(table, "reloadData");
}
},["@action","id"]), new objj_method(sel_getUid("deleteItemFromList:"), function $PageViewController__deleteItemFromList_(self, _cmd, sender)
{ with(self)
{
    var row = objj_msgSend(table, "selectedRow");
    if(objj_msgSend(page, "isListType")) {
        objj_msgSend(page, "removeChild:", row);
    } else {
        var key = objj_msgSend(objj_msgSend(page, "attributes"), "allKeys")[row];
        objj_msgSend(objj_msgSend(page, "attributes"), "removeObjectForKey:", key);
    }
    objj_msgSend(table, "deselectAll");
    objj_msgSend(table, "reloadData");
    objj_msgSend(self, "tableViewSelectionDidChange:", null);
}
},["@action","id"]), new objj_method(sel_getUid("rowClicked:"), function $PageViewController__rowClicked_(self, _cmd, notification)
{ with(self)
{

    if(objj_msgSend(page, "isListType")) {
        var row = objj_msgSend(notification, "object");
        page = objj_msgSend(objj_msgSend(page, "children"), "objectAtIndex:", row);

        objj_msgSend(objj_msgSend(CPPropertyAnimation, "slideLeft:view:", self, scrollView), "startAnimation");

        objj_msgSend(self, "myRefresh");
    }

}
},["void","id"]), new objj_method(sel_getUid("animationDidEnd:"), function $PageViewController__animationDidEnd_(self, _cmd, animation)
{ with(self)
{
    console.log("animationDidEnd");
}
},["void","CPAnimation"]), new objj_method(sel_getUid("backButtonClicked:"), function $PageViewController__backButtonClicked_(self, _cmd, sender)
{ with(self)
{
    objj_msgSend(objj_msgSend(CPPropertyAnimation, "slideRight:view:", self, scrollView), "startAnimation");

    page = objj_msgSend(page, "ancestor");
    objj_msgSend(self, "myRefresh");
}
},["@action","id"]), new objj_method(sel_getUid("pageTypeClicked:"), function $PageViewController__pageTypeClicked_(self, _cmd, sender)
{ with(self)
{
    var title = objj_msgSend(objj_msgSend(sender, "selectedItem"), "title");
    page.type = title;
    objj_msgSend(self, "myRefresh");
}
},["@action","id"]), new objj_method(sel_getUid("myRefresh"), function $PageViewController__myRefresh(self, _cmd)
{ with(self)
{
    objj_msgSend(table, "reloadData");
    objj_msgSend(backButton, "setEnabled:", page.ancestor != null);



    objj_msgSend(table, "deselectAll");
    var title = page.title;
    if(page.subtitle != null) {
        title += " (" + page.subtitle + ")";
    }
    objj_msgSend(titleField, "setObjectValue:", title);

    var header1 = objj_msgSend(objj_msgSend(table, "tableColumns")[0], "headerView");
    var header2 = objj_msgSend(objj_msgSend(table, "tableColumns")[1], "headerView");
    if(objj_msgSend(page, "isListType")) {
        objj_msgSend(header1, "setStringValue:", "Title");
        objj_msgSend(header2, "setStringValue:", "Subtitle");
    } else {
        objj_msgSend(header1, "setStringValue:", "Attribute");
        objj_msgSend(header2, "setStringValue:", "Value");
    }
    objj_msgSend(pagetypeButton, "selectItemWithTitle:", page.type);
}
},["void"])]);
}

e;