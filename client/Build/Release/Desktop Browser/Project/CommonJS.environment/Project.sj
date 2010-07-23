@STATIC;1.0;p;15;AppController.jt;6173;@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;10;PageView.ji;20;PageViewController.ji;12;LoginPanel.jt;6061;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("Page.j",YES);
objj_executeFile("PageView.j",YES);
objj_executeFile("PageViewController.j",YES);
objj_executeFile("LoginPanel.j",YES);
var _1=objj_allocateClassPair(CPObject,"AppController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("theWindow"),new objj_ivar("box"),new objj_ivar("saveButton"),new objj_ivar("loadButton"),new objj_ivar("previewButton"),new objj_ivar("rootPage"),new objj_ivar("appnameField"),new objj_ivar("pageView"),new objj_ivar("pageViewController"),new objj_ivar("baseURL"),new objj_ivar("appId"),new objj_ivar("listConnection"),new objj_ivar("saveConnection")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("applicationDidFinishLaunching:"),function(_3,_4,_5){
with(_3){
}
}),new objj_method(sel_getUid("resetData"),function(_6,_7){
with(_6){
rootPage=objj_msgSend(objj_msgSend(Page,"alloc"),"init");
objj_msgSend(rootPage,"setTitle:",objj_msgSend(appnameField,"objectValue"));
pageViewController.page=rootPage;
appId=null;
}
}),new objj_method(sel_getUid("awakeFromCib"),function(_8,_9){
with(_8){
baseURL="http://localhost:3000/";
objj_msgSend(box,"setBorderType:",CPLineBorder);
objj_msgSend(box,"setBorderWidth:",1);
objj_msgSend(box,"setBorderColor:",objj_msgSend(CPColor,"grayColor"));
pageViewController=objj_msgSend(objj_msgSend(PageViewController,"alloc"),"initWithCibName:bundle:","PageView",nil);
objj_msgSend(pageViewController,"setPage:",rootPage);
objj_msgSend(objj_msgSend(pageViewController,"view"),"setFrame:",CPRectMake(1,1,500,443));
objj_msgSend(pageView,"addSubview:",objj_msgSend(pageViewController,"view"));
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_8,sel_getUid("pageDidChange:"),"PageChangedNotification",rootPage);
objj_msgSend(previewButton,"setBordered:",NO);
previewButton._DOMElement.style.textDecoration="underline";
objj_msgSend(previewButton,"setTextColor:",objj_msgSend(CPColor,"blueColor"));
objj_msgSend(previewButton,"setAlignment:",CPLeftTextAlignment);
objj_msgSend(previewButton,"setTarget:",_8);
objj_msgSend(previewButton,"setAction:",sel_getUid("openMobileApp"));
previewButton._DOMElement.style.cursor="pointer";
objj_msgSend(_8,"resetData");
objj_msgSend(rootPage,"setTitle:","FOWA2010");
objj_msgSend(appnameField,"setObjectValue:","FOWA2010");
objj_msgSend(_8,"myRefresh");
}
}),new objj_method(sel_getUid("openMobileApp"),function(_a,_b){
with(_a){
var _c=baseURL+"a/"+appId;
window.open(_c,"mywindow");
}
}),new objj_method(sel_getUid("pageDidChange:"),function(_d,_e,_f){
with(_d){
objj_msgSend(saveButton,"setEnabled:",rootPage.title.length>0);
}
}),new objj_method(sel_getUid("controlTextDidChange:"),function(_10,_11,_12){
with(_10){
var _13=objj_msgSend(objj_msgSend(appnameField,"objectValue"),"length");
objj_msgSend(rootPage,"setTitle:",objj_msgSend(appnameField,"objectValue"));
objj_msgSend(_10,"myRefresh");
}
}),new objj_method(sel_getUid("myRefresh"),function(_14,_15){
with(_14){
var _16=rootPage.title.length>0;
objj_msgSend(saveButton,"setEnabled:",_16);
objj_msgSend(loadButton,"setEnabled:",_16);
objj_msgSend(pageViewController,"myRefresh");
var _17=baseURL+"a/"+appId;
if(appId){
objj_msgSend(previewButton,"setTitle:",_17);
}else{
objj_msgSend(previewButton,"setTitle:","");
}
}
}),new objj_method(sel_getUid("load:"),function(_18,_19,_1a){
with(_18){
console.log("loading...");
var _1b=objj_msgSend(CPURLRequest,"requestWithURL:",baseURL+"agenda/"+rootPage.title);
objj_msgSend(_1b,"setHTTPMethod:","GET");
listConnection=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_1b,_18);
}
}),new objj_method(sel_getUid("login:"),function(_1c,_1d,_1e){
with(_1c){
objj_msgSend(objj_msgSend(objj_msgSend(LoginPanel,"alloc"),"init:",_1c),"orderFront:",nil);
}
}),new objj_method(sel_getUid("panelDidClose:"),function(_1f,_20,tag){
with(_1f){
if(tag==1){
console.log("login success");
}else{
console.log("login canceled");
}
}
}),new objj_method(sel_getUid("new:"),function(_21,_22,_23){
with(_21){
console.log("new");
objj_msgSend(appnameField,"setObjectValue:","");
objj_msgSend(_21,"resetData");
objj_msgSend(_21,"myRefresh");
}
}),new objj_method(sel_getUid("save:"),function(_24,_25,_26){
with(_24){
var _27=objj_msgSend(CPURLRequest,"requestWithURL:",baseURL+"agenda");
objj_msgSend(_27,"setHTTPMethod:","POST");
var _28="{\"_id\":\""+appId+"\", \"rootpage\":"+objj_msgSend(rootPage,"toJSON")+"}";
console.log("Saving JSON: "+_28);
objj_msgSend(_27,"setHTTPBody:",_28);
objj_msgSend(_27,"setValue:forHTTPHeaderField:","application/json","Accept");
objj_msgSend(_27,"setValue:forHTTPHeaderField:","application/json","Content-Type");
saveConnection=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_27,_24);
}
}),new objj_method(sel_getUid("connection:didReceiveData:"),function(_29,_2a,_2b,_2c){
with(_29){
console.log("didReceiveData: '"+_2c+"'");
if(_2b==saveConnection){
var _2d=objj_msgSend(objj_msgSend(CPAlert,"alloc"),"init");
objj_msgSend(_2d,"setAlertStyle:",CPInformationalAlertStyle);
objj_msgSend(_2d,"setMessageText:","Saved!");
objj_msgSend(_2d,"addButtonWithTitle:","OK");
objj_msgSend(_2d,"runModal");
}
if(_2c!=""){
objj_msgSend(_29,"didReceiveLoadData:",_2c);
}else{
alert("Couldn't find Agenda: \""+rootPage.title+"\"");
objj_msgSend(_29,"resetData");
objj_msgSend(_29,"myRefresh");
}
}
}),new objj_method(sel_getUid("didReceiveLoadData:"),function(_2e,_2f,_30){
with(_2e){
try{
var obj=JSON.parse(_30);
var _31=objj_msgSend(Page,"initFromJSONObject:",obj.rootpage);
_2e.appId=obj._id;
objj_msgSend(pageViewController,"setPage:",_31);
objj_msgSend(_2e,"myRefresh");
}
catch(e){
console.log("Error in didReceiveData. "+e);
alert(e);
}
}
}),new objj_method(sel_getUid("connection:didFailWithError:"),function(_32,_33,_34,_35){
with(_32){
console.log("didFailWithError: "+_35);
alert(_35);
}
}),new objj_method(sel_getUid("connection:didReceiveResponse:"),function(_36,_37,_38,_39){
with(_36){
console.log("didReceiveResponse for URL:"+objj_msgSend(_39,"URL"));
}
})]);
p;18;ButtonColumnView.jt;1627;@STATIC;1.0;I;15;AppKit/CPView.jt;1588;
objj_executeFile("AppKit/CPView.j",NO);
var _1=objj_allocateClassPair(CPView,"ButtonColumnView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("button"),new objj_ivar("row"),new objj_ivar("delegate")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:andDelegate:"),function(_3,_4,_5,_6){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("ButtonColumnView").super_class},"initWithFrame:",_5);
button=objj_msgSend(CPButton,"buttonWithTitle:",">");
objj_msgSend(button,"setCenter:",CPPointMake(10,25));
objj_msgSend(_3,"addSubview:",button);
objj_msgSend(button,"setTarget:",_3);
objj_msgSend(button,"setAction:",sel_getUid("rowSelected:"));
_3.delegate=_6;
return _3;
}
}),new objj_method(sel_getUid("setObjectValue:"),function(_7,_8,_9){
with(_7){
row=_9;
objj_msgSend(button,"setTitle:",">");
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_a,_b,_c){
with(_a){
_a=objj_msgSendSuper({receiver:_a,super_class:objj_getClass("ButtonColumnView").super_class},"initWithCoder:",_c);
button=objj_msgSend(_c,"decodeObjectForKey:","button");
return _a;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_d,_e,_f){
with(_d){
objj_msgSendSuper({receiver:_d,super_class:objj_getClass("ButtonColumnView").super_class},"encodeWithCoder:",_f);
objj_msgSend(_f,"encodeObject:forKey:",button,"button");
}
}),new objj_method(sel_getUid("rowSelected:"),function(_10,_11,_12){
with(_10){
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:","RowClickedNotification",row);
}
})]);
p;21;CPPropertyAnimation.jt;5747;@STATIC;1.0;I;20;AppKit/CPAnimation.jt;5703;
objj_executeFile("AppKit/CPAnimation.j",NO);
var _1=objj_allocateClassPair(CPAnimation,"CPPropertyAnimation"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("view"),new objj_ivar("properties"),new objj_ivar("_startView"),new objj_ivar("_endView"),new objj_ivar("_startFrame"),new objj_ivar("_finalDelegate"),new objj_ivar("direction")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("direction"),function(_3,_4){
with(_3){
return direction;
}
}),new objj_method(sel_getUid("setDirection:"),function(_5,_6,_7){
with(_5){
direction=_7;
}
}),new objj_method(sel_getUid("initWithView:"),function(_8,_9,_a){
with(_8){
_8=objj_msgSendSuper({receiver:_8,super_class:objj_getClass("CPPropertyAnimation").super_class},"initWithDuration:animationCurve:",0.4,CPAnimationEaseOut);
if(_8){
view=_a;
_startFrame=CGRectMakeCopy(objj_msgSend(_a,"frame"));
properties=objj_msgSend(CPDictionary,"dictionary");
}
return _8;
}
}),new objj_method(sel_getUid("animationDidEnd:"),function(_b,_c,_d){
with(_b){
var _e;
if(_d.direction==="left"){
_e=CGRectMake(_startFrame.origin.x+_startFrame.size.width,_startFrame.origin.y,_startFrame.size.width,_startFrame.size.height);
}else{
_e=CGRectMake(_startFrame.origin.x-_startFrame.size.width,_startFrame.origin.y,_startFrame.size.width,_startFrame.size.height);
}
var _f=objj_msgSend(objj_msgSend(CPPropertyAnimation,"alloc"),"initWithView:",view);
objj_msgSend(_f,"setDelegate:",_finalDelegate);
objj_msgSend(_f,"addProperty:start:end:","frame",_e,_startFrame);
objj_msgSend(_f,"startAnimation");
}
}),new objj_method(sel_getUid("view"),function(_10,_11){
with(_10){
return view;
}
}),new objj_method(sel_getUid("addProperty:start:end:"),function(_12,_13,_14,_15,_16){
with(_12){
if(!objj_msgSend(view,"respondsToSelector:",_14)){
return;
}
objj_msgSend(properties,"setObject:forKey:",{start:_15,end:_16},_14);
objj_msgSend(view,"setValue:forKey:",_15,_14);
}
}),new objj_method(sel_getUid("addToViewOnStart:"),function(_17,_18,_19){
with(_17){
_startView=_19;
}
}),new objj_method(sel_getUid("willAddToViewOnStart"),function(_1a,_1b){
with(_1a){
return _startView;
}
}),new objj_method(sel_getUid("removeFromSuperviewOnEnd:"),function(_1c,_1d,_1e){
with(_1c){
_endView=_1e;
}
}),new objj_method(sel_getUid("willRemoveFromSuperviewOnEnd"),function(_1f,_20){
with(_1f){
return _endView;
}
}),new objj_method(sel_getUid("setCurrentProgress:"),function(_21,_22,_23){
with(_21){
objj_msgSendSuper({receiver:_21,super_class:objj_getClass("CPPropertyAnimation").super_class},"setCurrentProgress:",_23);
var _23=objj_msgSend(_21,"currentValue");
var _24=objj_msgSend(properties,"allKeys"),_25=objj_msgSend(_24,"count");
for(var i=0;i<_25;i++){
var _26=_24[i],_27=objj_msgSend(properties,"objectForKey:",_26);
if(!_27){
continue;
}
var _28=_27.start,end=_27.end,_29;
if(_26=="width"||_26=="height"){
_29=(_23*(end-_28))+_28;
}else{
if(_26=="size"){
_29=CGSizeMake((_23*(end.width-_28.width))+_28.width,(_23*(end.height-_28.height))+_28.height);
}else{
if(_26=="frame"){
_29=CGRectMake((_23*(end.origin.x-_28.origin.x))+_28.origin.x,(_23*(end.origin.y-_28.origin.y))+_28.origin.y,(_23*(end.size.width-_28.size.width))+_28.size.width,(_23*(end.size.height-_28.size.height))+_28.size.height);
}else{
if(_26=="alphaValue"){
_29=(_23*(end-_28))+_28;
}else{
if(_26=="backgroundColor"||_26=="textColor"||_26=="textShadowColor"){
var red=(_23*(objj_msgSend(end,"redComponent")-objj_msgSend(_28,"redComponent")))+objj_msgSend(_28,"redComponent"),_2a=(_23*(objj_msgSend(end,"greenComponent")-objj_msgSend(_28,"greenComponent")))+objj_msgSend(_28,"greenComponent"),_2b=(_23*(objj_msgSend(end,"blueComponent")-objj_msgSend(_28,"blueComponent")))+objj_msgSend(_28,"blueComponent"),_2c=(_23*(objj_msgSend(end,"alphaComponent")-objj_msgSend(_28,"alphaComponent")))+objj_msgSend(_28,"alphaComponent");
_29=objj_msgSend(CPColor,"colorWithCalibratedRed:green:blue:alpha:",red,_2a,_2b,_2c);
}
}
}
}
}
objj_msgSend(view,"setValue:forKey:",_29,_26);
}
}
}),new objj_method(sel_getUid("startAnimation"),function(_2d,_2e){
with(_2d){
var _2f=objj_msgSend(properties,"count");
for(var i=0;i<_2f;i++){
var _30=objj_msgSend(properties,"allKeys")[i],_31=objj_msgSend(properties,"objectForKey:",_30);
if(!_31){
continue;
}
objj_msgSend(view,"setValue:forKey:",_31.start,_30);
}
if(_startView){
objj_msgSend(_startView,"addSubview:",view);
}
objj_msgSendSuper({receiver:_2d,super_class:objj_getClass("CPPropertyAnimation").super_class},"startAnimation");
}
}),new objj_method(sel_getUid("animationTimerDidFire:"),function(_32,_33,_34){
with(_32){
objj_msgSendSuper({receiver:_32,super_class:objj_getClass("CPPropertyAnimation").super_class},"animationTimerDidFire:",_34);
if(_progress===1&&_endView){
objj_msgSend(view,"removeFromSuperview");
}
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("slideLeft:view:"),function(_35,_36,_37,_38){
with(_35){
var _39=objj_msgSend(_38,"frame");
var _3a=CGRectMake(_39.origin.x-_39.size.width,_39.origin.y,_39.size.width,_39.size.height);
var _3b=objj_msgSend(objj_msgSend(CPPropertyAnimation,"alloc"),"initWithView:",_38);
_3b.direction="left";
objj_msgSend(_3b,"setDelegate:",_3b);
objj_msgSend(_3b,"addProperty:start:end:","frame",_39,_3a);
_finalDelegate=_37;
return _3b;
}
}),new objj_method(sel_getUid("slideRight:view:"),function(_3c,_3d,_3e,_3f){
with(_3c){
var _40=objj_msgSend(_3f,"frame");
var _41=CGRectMake(_40.origin.x+_40.size.width,_40.origin.y,_40.size.width,_40.size.height);
var _42=objj_msgSend(objj_msgSend(CPPropertyAnimation,"alloc"),"initWithView:",_3f);
_42.direction="right";
objj_msgSend(_42,"setDelegate:",_42);
objj_msgSend(_42,"addProperty:start:end:","frame",_40,_41);
_finalDelegate=_3e;
return _42;
}
})]);
p;12;LoginPanel.jt;2986;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.jt;2920;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("AppKit/CPPanel.j",NO);
var _1=objj_allocateClassPair(CPPanel,"LoginPanel"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("init:"),function(_8,_9,_a){
with(_8){
_8=objj_msgSend(_8,"initWithContentRect:styleMask:",CGRectMake(100,100,350,150),CPHUDBackgroundWindowMask);
if(_8){
_8.delegate=_a;
objj_msgSend(_8,"setTitle:","Login");
objj_msgSend(_8,"setFloatingPanel:",YES);
var _b=objj_msgSend(_8,"contentView"),_c=objj_msgSend(_b,"bounds");
var _d=objj_msgSend(CPTextField,"labelWithTitle:","Enter your email and password to login.");
objj_msgSend(_d,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(_d,"sizeToFit");
objj_msgSend(_d,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_d,"setFrameOrigin:",CGPointMake(45,5));
objj_msgSend(_b,"addSubview:",_d);
var _e=objj_msgSend(CPTextField,"labelWithTitle:","Email:");
objj_msgSend(_e,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_e,"setFrameOrigin:",CGPointMake(62,40));
objj_msgSend(_b,"addSubview:",_e);
var _f=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","",200);
objj_msgSend(_f,"setFrameOrigin:",CGPointMake(100,35));
objj_msgSend(_b,"addSubview:",_f);
var _10=objj_msgSend(CPTextField,"labelWithTitle:","Password:");
objj_msgSend(_10,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_10,"setFrameOrigin:",CGPointMake(40,70));
objj_msgSend(_b,"addSubview:",_10);
var _11=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","",200);
objj_msgSend(_11,"setFrameOrigin:",CGPointMake(100,65));
objj_msgSend(_11,"setSecure:",YES);
objj_msgSend(_b,"addSubview:",_11);
var _12=objj_msgSend(CPButton,"buttonWithTitle:theme:","Login",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_12,"setFrame:",CGRectMake(250,120,70,20));
objj_msgSend(_b,"addSubview:",_12);
objj_msgSend(_12,"setTag:",1);
objj_msgSend(_12,"setTarget:",_8);
objj_msgSend(_12,"setAction:",sel_getUid("buttonAction:"));
var _13=objj_msgSend(CPButton,"buttonWithTitle:theme:","Cancel",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_13,"setFrame:",CGRectMake(170,120,70,20));
objj_msgSend(_b,"addSubview:",_13);
objj_msgSend(_13,"setTag:",0);
objj_msgSend(_13,"setTarget:",_8);
objj_msgSend(_13,"setAction:",sel_getUid("buttonAction:"));
}
return _8;
}
}),new objj_method(sel_getUid("buttonAction:"),function(_14,_15,_16){
with(_14){
if(objj_msgSend(delegate,"respondsToSelector:",sel_getUid("panelDidClose:"))){
objj_msgSend(delegate,"panelDidClose:",objj_msgSend(_16,"tag"));
}
objj_msgSend(_14,"close");
}
})]);
p;6;main.jt;267;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jt;181;
objj_executeFile("Foundation/Foundation.j",NO);
objj_executeFile("AppKit/AppKit.j",NO);
objj_executeFile("AppController.j",YES);
main=function(_1,_2){
CPApplicationMain(_1,_2);
};
p;6;Page.jt;3650;@STATIC;1.0;I;21;Foundation/CPObject.jt;3605;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"Page"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("title"),new objj_ivar("subtitle"),new objj_ivar("children"),new objj_ivar("ancestor"),new objj_ivar("type"),new objj_ivar("attributes")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("title"),function(_3,_4){
with(_3){
return title;
}
}),new objj_method(sel_getUid("setTitle:"),function(_5,_6,_7){
with(_5){
title=_7;
}
}),new objj_method(sel_getUid("subtitle"),function(_8,_9){
with(_8){
return subtitle;
}
}),new objj_method(sel_getUid("setSubtitle:"),function(_a,_b,_c){
with(_a){
subtitle=_c;
}
}),new objj_method(sel_getUid("children"),function(_d,_e){
with(_d){
return children;
}
}),new objj_method(sel_getUid("setChildren:"),function(_f,_10,_11){
with(_f){
children=_11;
}
}),new objj_method(sel_getUid("ancestor"),function(_12,_13){
with(_12){
return ancestor;
}
}),new objj_method(sel_getUid("setAncestor:"),function(_14,_15,_16){
with(_14){
ancestor=_16;
}
}),new objj_method(sel_getUid("type"),function(_17,_18){
with(_17){
return type;
}
}),new objj_method(sel_getUid("setType:"),function(_19,_1a,_1b){
with(_19){
type=_1b;
}
}),new objj_method(sel_getUid("attributes"),function(_1c,_1d){
with(_1c){
return attributes;
}
}),new objj_method(sel_getUid("setAttributes:"),function(_1e,_1f,_20){
with(_1e){
attributes=_20;
}
}),new objj_method(sel_getUid("init"),function(_21,_22){
with(_21){
_21=objj_msgSendSuper({receiver:_21,super_class:objj_getClass("Page").super_class},"init");
children=objj_msgSend(objj_msgSend(CPArray,"alloc"),"init");
attributes=objj_msgSend(CPDictionary,"dictionary");
type="Navigation";
return _21;
}
}),new objj_method(sel_getUid("initWithTitle:andSubtitle:andType:"),function(_23,_24,_25,_26,_27){
with(_23){
_23=objj_msgSend(_23,"init");
title=_25;
subtitle=_26;
type=_27;
return _23;
}
}),new objj_method(sel_getUid("addChild:"),function(_28,_29,_2a){
with(_28){
objj_msgSend(_2a,"setAncestor:",_28);
objj_msgSend(children,"addObject:",_2a);
}
}),new objj_method(sel_getUid("removeChild:"),function(_2b,_2c,_2d){
with(_2b){
objj_msgSend(children,"removeObjectAtIndex:",_2d);
}
}),new objj_method(sel_getUid("toJSON"),function(_2e,_2f){
with(_2e){
var _30="";
for(var i=0;i<children.length;i++){
_30+=objj_msgSend(children[i],"toJSON");
_30+=",";
}
if(_30.length>0){
_30=_30.substring(0,_30.length-1);
}
var _31="";
for(var i=0;i<objj_msgSend(attributes,"allKeys").length;i++){
var key=objj_msgSend(attributes,"allKeys")[i];
var _32=objj_msgSend(attributes,"objectForKey:",key);
_31+=JSON.stringify(key)+":"+JSON.stringify(_32);
_31+=",";
}
if(_31.length>0){
_31=_31.substring(0,_31.length-1);
}
var _33="{\"title\":\""+title;
if(subtitle){
_33+="\",\"subtitle\":\""+subtitle;
}
_33+="\",\"type\":\""+type+"\",\"children\":["+_30+"],\"attributes\":{"+_31+"}}";
return _33;
}
}),new objj_method(sel_getUid("description"),function(_34,_35){
with(_34){
return title;
}
}),new objj_method(sel_getUid("isNavigationType"),function(_36,_37){
with(_36){
return type==="Navigation";
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("initFromJSONObject:"),function(_38,_39,_3a){
with(_38){
var _3b=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:",_3a.title,_3a.subtitle,_3a.type);
for(var i=0;i<_3a.children.length;i++){
var _3c=objj_msgSend(Page,"initFromJSONObject:",_3a.children[i]);
objj_msgSend(_3b,"addChild:",_3c);
}
for(var key in _3a.attributes){
objj_msgSend(objj_msgSend(_3b,"attributes"),"setValue:forKey:",_3a.attributes[key],key);
}
return _3b;
}
})]);
p;10;PageView.jt;434;@STATIC;1.0;I;15;AppKit/CPView.jt;396;
objj_executeFile("AppKit/CPView.j",NO);
var _1=objj_allocateClassPair(CPView,"PageView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("PageView").super_class},"initWithFrame:",_5)){
console.log("PageView.initWithFrame");
}
return _3;
}
})]);
p;20;PageViewController.jt;9244;@STATIC;1.0;I;21;Foundation/CPObject.ji;18;ButtonColumnView.ji;21;CPPropertyAnimation.jt;9150;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("ButtonColumnView.j",YES);
objj_executeFile("CPPropertyAnimation.j",YES);
var _1=objj_allocateClassPair(CPViewController,"PageViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("scrollView"),new objj_ivar("page"),new objj_ivar("deleteButton"),new objj_ivar("addButton"),new objj_ivar("backButton"),new objj_ivar("editButton"),new objj_ivar("pagetypeButton"),new objj_ivar("table"),new objj_ivar("titleField"),new objj_ivar("itemsLabel"),new objj_ivar("editing")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("page"),function(_3,_4){
with(_3){
return page;
}
}),new objj_method(sel_getUid("setPage:"),function(_5,_6,_7){
with(_5){
page=_7;
}
}),new objj_method(sel_getUid("editing"),function(_8,_9){
with(_8){
return editing;
}
}),new objj_method(sel_getUid("setEditing:"),function(_a,_b,_c){
with(_a){
editing=_c;
}
}),new objj_method(sel_getUid("initWithCibName:bundle:"),function(_d,_e,_f,_10){
with(_d){
if(_d=objj_msgSendSuper({receiver:_d,super_class:objj_getClass("PageViewController").super_class},"initWithCibName:bundle:",_f,_10)){
}
return _d;
}
}),new objj_method(sel_getUid("awakeFromCib"),function(_11,_12){
with(_11){
table=objj_msgSend(objj_msgSend(CPTableView,"alloc"),"initWithFrame:",CGRectMake(0,0,200,600));
var _13=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","first");
objj_msgSend(objj_msgSend(_13,"headerView"),"setStringValue:","Title");
objj_msgSend(_13,"setWidth:",200);
objj_msgSend(_13,"setEditable:",YES);
objj_msgSend(table,"addTableColumn:",_13);
var _14=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","second");
objj_msgSend(objj_msgSend(_14,"headerView"),"setStringValue:","Subtitle");
objj_msgSend(_14,"setWidth:",260);
objj_msgSend(_14,"setEditable:",YES);
objj_msgSend(table,"addTableColumn:",_14);
var _15=objj_msgSend(objj_msgSend(ButtonColumnView,"alloc"),"initWithFrame:andDelegate:",CGRectMake(0,0,10,20),_11);
var _16=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","button");
objj_msgSend(_16,"setDataView:",_15);
objj_msgSend(_16,"setWidth:",20);
objj_msgSend(_16,"setEditable:",YES);
objj_msgSend(table,"addTableColumn:",_16);
objj_msgSend(table,"setUsesAlternatingRowBackgroundColors:",YES);
objj_msgSend(table,"setRowHeight:",50);
objj_msgSend(table,"setDataSource:",_11);
objj_msgSend(table,"setDelegate:",_11);
objj_msgSend(table,"setAllowsColumnSelection:",NO);
objj_msgSend(scrollView,"setDocumentView:",table);
objj_msgSend(deleteButton,"setEnabled:",NO);
objj_msgSend(backButton,"setEnabled:",NO);
objj_msgSend(pagetypeButton,"removeAllItems");
objj_msgSend(pagetypeButton,"addItemsWithTitles:",["Navigation","Detail"]);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_11,sel_getUid("tableViewSelectionDidChange:"),CPTableViewSelectionDidChangeNotification,nil);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_11,sel_getUid("rowClicked:"),"RowClickedNotification",nil);
}
}),new objj_method(sel_getUid("tableView:shouldEditTableColumn:row:"),function(_17,_18,_19,_1a,row){
with(_17){
objj_msgSend(_17,"setEditing:",NO);
objj_msgSend(_17,"toggleEditing:",_19);
return YES;
}
}),new objj_method(sel_getUid("toggleEditing:"),function(_1b,_1c,_1d){
with(_1b){
var _1e;
if(_1b.editing){
_1e=objj_msgSend(CPTextField,"labelWithTitle:","");
objj_msgSend(_1e,"setVerticalAlignment:",CPCenterTextAlignment);
objj_msgSend(_1b,"setEditing:",NO);
objj_msgSend(editButton,"setTitle:","Edit");
objj_msgSend(editButton,"unsetThemeState:",CPThemeStateDefault);
}else{
_1e=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","",100);
objj_msgSend(_1b,"setEditing:",YES);
objj_msgSend(editButton,"setTitle:","Done");
objj_msgSend(editButton,"setThemeState:",CPThemeStateDefault);
}
var _1f=objj_msgSend(table,"tableColumns");
objj_msgSend(_1f[0],"setDataView:",_1e);
objj_msgSend(_1f[1],"setDataView:",_1e);
objj_msgSend(_1b,"myRefresh");
}
}),new objj_method(sel_getUid("numberOfRowsInTableView:"),function(_20,_21,_22){
with(_20){
if(objj_msgSend(page,"isNavigationType")){
return objj_msgSend(objj_msgSend(page,"children"),"count");
}else{
return objj_msgSend(objj_msgSend(objj_msgSend(page,"attributes"),"allKeys"),"count");
}
}
}),new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"),function(_23,_24,_25,_26,row){
with(_23){
if(objj_msgSend(page,"isNavigationType")){
var _27=objj_msgSend(objj_msgSend(page,"children"),"objectAtIndex:",row);
if(objj_msgSend(objj_msgSend(_26,"identifier"),"isEqual:","first")){
return objj_msgSend(_27,"title");
}else{
if(objj_msgSend(objj_msgSend(_26,"identifier"),"isEqual:","second")){
return objj_msgSend(_27,"subtitle");
}else{
return row+"";
}
}
}else{
var key=objj_msgSend(objj_msgSend(page,"attributes"),"allKeys")[row];
var _28=objj_msgSend(objj_msgSend(page,"attributes"),"objectForKey:",key);
if(objj_msgSend(objj_msgSend(_26,"identifier"),"isEqual:","first")){
return key;
}else{
if(objj_msgSend(objj_msgSend(_26,"identifier"),"isEqual:","second")){
return _28;
}
}
}
}
}),new objj_method(sel_getUid("tableView:setObjectValue:forTableColumn:row:"),function(_29,_2a,_2b,_2c,_2d,row){
with(_29){
if(objj_msgSend(page,"isNavigationType")){
var _2e=objj_msgSend(objj_msgSend(page,"children"),"objectAtIndex:",row);
if(objj_msgSend(objj_msgSend(_2d,"identifier"),"isEqual:","first")){
objj_msgSend(_2e,"setTitle:",_2c);
}else{
objj_msgSend(_2e,"setSubtitle:",_2c);
}
}else{
var _2f=objj_msgSend(table,"tableColumns")[0];
var _30=objj_msgSend(table,"tableColumns")[1];
var _31=objj_msgSend(_29,"tableView:objectValueForTableColumn:row:",table,_2f,row);
var _32=objj_msgSend(_29,"tableView:objectValueForTableColumn:row:",table,_30,row);
if(objj_msgSend(objj_msgSend(_2d,"identifier"),"isEqual:","first")){
objj_msgSend(objj_msgSend(page,"attributes"),"removeObjectForKey:",_31);
objj_msgSend(objj_msgSend(page,"attributes"),"setValue:forKey:",_32,_2c);
}else{
objj_msgSend(objj_msgSend(page,"attributes"),"setValue:forKey:",_2c,_31);
}
}
}
}),new objj_method(sel_getUid("tableViewSelectionDidChange:"),function(_33,_34,_35){
with(_33){
var _36=objj_msgSend(objj_msgSend(table,"selectedRowIndexes"),"firstIndex");
objj_msgSend(deleteButton,"setEnabled:",_36>-1);
}
}),new objj_method(sel_getUid("addItemToList:"),function(_37,_38,_39){
with(_37){
if(objj_msgSend(page,"isNavigationType")){
var _3a=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:","The title of a subpage","The optional subtitle of a subpage","Navigation");
objj_msgSend(page,"addChild:",_3a);
}else{
objj_msgSend(objj_msgSend(page,"attributes"),"setValue:forKey:","A value","A attribute");
}
objj_msgSend(table,"reloadData");
}
}),new objj_method(sel_getUid("deleteItemFromList:"),function(_3b,_3c,_3d){
with(_3b){
var row=objj_msgSend(table,"selectedRow");
if(objj_msgSend(page,"isNavigationType")){
objj_msgSend(page,"removeChild:",row);
}else{
var key=objj_msgSend(objj_msgSend(page,"attributes"),"allKeys")[row];
objj_msgSend(objj_msgSend(page,"attributes"),"removeObjectForKey:",key);
}
objj_msgSend(table,"deselectAll");
objj_msgSend(table,"reloadData");
objj_msgSend(_3b,"tableViewSelectionDidChange:",null);
}
}),new objj_method(sel_getUid("rowClicked:"),function(_3e,_3f,_40){
with(_3e){
if(objj_msgSend(page,"isNavigationType")){
var row=objj_msgSend(_40,"object");
page=objj_msgSend(objj_msgSend(page,"children"),"objectAtIndex:",row);
objj_msgSend(objj_msgSend(CPPropertyAnimation,"slideLeft:view:",_3e,scrollView),"startAnimation");
objj_msgSend(_3e,"myRefresh");
}
}
}),new objj_method(sel_getUid("animationDidEnd:"),function(_41,_42,_43){
with(_41){
console.log("animationDidEnd");
}
}),new objj_method(sel_getUid("backButtonClicked:"),function(_44,_45,_46){
with(_44){
objj_msgSend(objj_msgSend(CPPropertyAnimation,"slideRight:view:",_44,scrollView),"startAnimation");
page=objj_msgSend(page,"ancestor");
objj_msgSend(_44,"myRefresh");
}
}),new objj_method(sel_getUid("pageTypeClicked:"),function(_47,_48,_49){
with(_47){
var _4a=objj_msgSend(objj_msgSend(_49,"selectedItem"),"title");
page.type=_4a;
objj_msgSend(_47,"myRefresh");
}
}),new objj_method(sel_getUid("myRefresh"),function(_4b,_4c){
with(_4b){
objj_msgSend(table,"reloadData");
objj_msgSend(backButton,"setEnabled:",page.ancestor!=null);
objj_msgSend(table,"deselectAll");
var _4d=page.title;
if(page.subtitle!=null){
_4d+=" ("+page.subtitle+")";
}
objj_msgSend(titleField,"setObjectValue:",_4d);
var _4e=objj_msgSend(objj_msgSend(table,"tableColumns")[0],"headerView");
var _4f=objj_msgSend(objj_msgSend(table,"tableColumns")[1],"headerView");
if(objj_msgSend(page,"isNavigationType")){
objj_msgSend(_4e,"setStringValue:","Title");
objj_msgSend(_4f,"setStringValue:","Subtitle");
objj_msgSend(itemsLabel,"setStringValue:","Subpages:");
}else{
objj_msgSend(_4e,"setStringValue:","Attribute");
objj_msgSend(_4f,"setStringValue:","Value");
objj_msgSend(itemsLabel,"setStringValue:","Attributes:");
}
objj_msgSend(pagetypeButton,"selectItemWithTitle:",page.type);
}
})]);
e;