@STATIC;1.0;p;15;AppController.jt;7483;@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;10;PageView.ji;20;PageViewController.ji;12;LoginPanel.ji;13;NewTemplate.jt;7353;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("Page.j",YES);
objj_executeFile("PageView.j",YES);
objj_executeFile("PageViewController.j",YES);
objj_executeFile("LoginPanel.j",YES);
objj_executeFile("NewTemplate.j",YES);
var _1=objj_allocateClassPair(CPObject,"AppController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("theWindow"),new objj_ivar("box"),new objj_ivar("saveButton"),new objj_ivar("loadButton"),new objj_ivar("previewButton"),new objj_ivar("logoutButton"),new objj_ivar("previewView"),new objj_ivar("rootPage"),new objj_ivar("appnameField"),new objj_ivar("pageView"),new objj_ivar("pageViewController"),new objj_ivar("baseURL"),new objj_ivar("appId"),new objj_ivar("listConnection"),new objj_ivar("saveConnection")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("applicationDidFinishLaunching:"),function(_3,_4,_5){
with(_3){
objj_msgSend(theWindow,"orderOut:",_3);
objj_msgSend(objj_msgSend(objj_msgSend(LoginPanel,"alloc"),"init:",_3),"orderFront:",nil);
}
}),new objj_method(sel_getUid("resetData"),function(_6,_7){
with(_6){
rootPage=objj_msgSend(objj_msgSend(Page,"alloc"),"init");
objj_msgSend(rootPage,"setTitle:",objj_msgSend(appnameField,"objectValue"));
rootPage.mobileNavId="r";
pageViewController.page=rootPage;
appId=null;
}
}),new objj_method(sel_getUid("awakeFromCib"),function(_8,_9){
with(_8){
baseURL="http://agendium.heroku.com/";
objj_msgSend(box,"setBorderType:",CPLineBorder);
objj_msgSend(box,"setBorderWidth:",1);
objj_msgSend(box,"setBorderColor:",objj_msgSend(CPColor,"grayColor"));
pageViewController=objj_msgSend(objj_msgSend(PageViewController,"alloc"),"initWithCibName:bundle:","PageView",nil);
objj_msgSend(pageViewController,"setPage:",rootPage);
objj_msgSend(pageViewController,"setDelegate:",_8);
objj_msgSend(objj_msgSend(pageViewController,"view"),"setFrame:",CPRectMake(1,1,550,501));
objj_msgSend(pageView,"addSubview:",objj_msgSend(pageViewController,"view"));
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_8,sel_getUid("pageDidChange:"),"PageChangedNotification",rootPage);
objj_msgSend(previewButton,"setBordered:",NO);
previewButton._DOMElement.style.textDecoration="underline";
objj_msgSend(previewButton,"setTextColor:",objj_msgSend(CPColor,"blueColor"));
objj_msgSend(previewButton,"setAlignment:",CPLeftTextAlignment);
objj_msgSend(previewButton,"setTarget:",_8);
objj_msgSend(previewButton,"setAction:",sel_getUid("openMobileApp"));
previewButton._DOMElement.style.cursor="pointer";
objj_msgSend(previewView,"setFrame:",CPRectMake(540,100,340,520));
previewView._DOMElement.style.webkitTransformOrigin="10 10";
previewView._DOMElement.style.webkitTransform="scale(0.75)";
objj_msgSend(logoutButton,"setBordered:",NO);
objj_msgSend(logoutButton,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:","Resources/logout2.png"));
logoutButton._DOMElement.style.textDecoration="underline";
logoutButton._DOMElement.style.cursor="pointer";
objj_msgSend(_8,"resetData");
objj_msgSend(appnameField,"setValue:forThemeAttribute:inState:",objj_msgSend(CPColor,"lightGrayColor"),"text-color",CPTextFieldStatePlaceholder);
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
}),new objj_method(sel_getUid("selectedPage:reverse:"),function(_14,_15,_16,_17){
with(_14){
var cmd="jQT.goTo(\"#"+_16.navigationId+"\", \"slide\"";
if(_17){
cmd+=", \"reverse\"";
}
cmd+=");";
console.log("cmd "+cmd);
objj_msgSend(objj_msgSend(previewView,"windowScriptObject"),"evaluateWebScript:",cmd);
}
}),new objj_method(sel_getUid("myRefresh"),function(_18,_19){
with(_18){
var _1a=rootPage.title.length>0;
objj_msgSend(saveButton,"setEnabled:",_1a);
objj_msgSend(loadButton,"setEnabled:",_1a);
objj_msgSend(pageViewController,"myRefresh");
var _1b=baseURL+"a/"+appId;
if(appId){
objj_msgSend(previewView,"setMainFrameURL:",_1b);
objj_msgSend(previewButton,"setTitle:",_1b);
}else{
objj_msgSend(previewButton,"setTitle:","");
objj_msgSend(previewView,"setMainFrameURL:",baseURL+"preview");
}
}
}),new objj_method(sel_getUid("load:"),function(_1c,_1d,_1e){
with(_1c){
console.log("loading...");
var _1f=objj_msgSend(CPURLRequest,"requestWithURL:",baseURL+"agenda/"+rootPage.title);
objj_msgSend(_1f,"setHTTPMethod:","GET");
listConnection=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_1f,_1c);
}
}),new objj_method(sel_getUid("login:"),function(_20,_21,_22){
with(_20){
history.go(-1);
}
}),new objj_method(sel_getUid("panelDidClose:"),function(_23,_24,tag){
with(_23){
if(tag==1){
console.log("login success");
objj_msgSend(theWindow,"orderFront:",_23);
}else{
console.log("login canceled");
history.go(-1);
}
}
}),new objj_method(sel_getUid("new:"),function(_25,_26,_27){
with(_25){
objj_msgSend(appnameField,"setObjectValue:","");
objj_msgSend(_25,"resetData");
var _28=objj_msgSend(NewTemplate,"data");
objj_msgSend(_25,"didReceiveLoadData:",_28);
}
}),new objj_method(sel_getUid("save:"),function(_29,_2a,_2b){
with(_29){
var _2c=objj_msgSend(CPURLRequest,"requestWithURL:",baseURL+"agenda");
objj_msgSend(_2c,"setHTTPMethod:","POST");
var _2d="{\"_id\":\""+appId+"\", \"rootpage\":"+objj_msgSend(rootPage,"toJSON")+"}";
console.log("Saving JSON: "+_2d);
objj_msgSend(_2c,"setHTTPBody:",_2d);
objj_msgSend(_2c,"setValue:forHTTPHeaderField:","application/json","Accept");
objj_msgSend(_2c,"setValue:forHTTPHeaderField:","application/json","Content-Type");
saveConnection=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_2c,_29);
}
}),new objj_method(sel_getUid("connection:didReceiveData:"),function(_2e,_2f,_30,_31){
with(_2e){
console.log("didReceiveData: '"+_31+"'");
if(_30==saveConnection){
var _32=objj_msgSend(objj_msgSend(CPAlert,"alloc"),"init");
objj_msgSend(_32,"setAlertStyle:",CPInformationalAlertStyle);
objj_msgSend(_32,"setMessageText:","Saved!");
objj_msgSend(_32,"addButtonWithTitle:","OK");
objj_msgSend(_32,"runModal");
}
if(_31!=""){
objj_msgSend(_2e,"didReceiveLoadData:",_31);
}else{
alert("Couldn't find Agenda: \""+rootPage.title+"\"");
objj_msgSend(_2e,"resetData");
objj_msgSend(_2e,"myRefresh");
}
}
}),new objj_method(sel_getUid("didReceiveLoadData:"),function(_33,_34,_35){
with(_33){
try{
var obj=JSON.parse(_35);
var _36=objj_msgSend(Page,"initFromJSONObject:andNavigationId:",obj.rootpage,"r");
_33.appId=obj._id;
objj_msgSend(pageViewController,"setPage:",_36);
objj_msgSend(_33,"myRefresh");
}
catch(e){
console.log("Error in didReceiveData. "+e);
alert(e);
}
}
}),new objj_method(sel_getUid("connection:didFailWithError:"),function(_37,_38,_39,_3a){
with(_37){
console.log("didFailWithError: "+_3a);
alert(_3a);
}
}),new objj_method(sel_getUid("connection:didReceiveResponse:"),function(_3b,_3c,_3d,_3e){
with(_3b){
console.log("didReceiveResponse for URL:"+objj_msgSend(_3e,"URL"));
}
})]);
p;18;ButtonColumnView.jt;2226;@STATIC;1.0;I;15;AppKit/CPView.jt;2187;
objj_executeFile("AppKit/CPView.j",NO);
var _1=objj_allocateClassPair(CPView,"ButtonColumnView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("button"),new objj_ivar("row"),new objj_ivar("delegate")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:andDelegate:"),function(_3,_4,_5,_6){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("ButtonColumnView").super_class},"initWithFrame:",_5);
button=objj_msgSend(CPButton,"buttonWithTitle:",">");
objj_msgSend(button,"setFrame:",CGRectMake(0,0,24,24));
objj_msgSend(button,"setCenter:",CPPointMake(12,25));
objj_msgSend(button,"setAction:",sel_getUid("rowSelected:"));
objj_msgSend(button,"setTarget:",_3);
objj_msgSend(_3,"addSubview:",button);
_3.delegate=_6;
return _3;
}
}),new objj_method(sel_getUid("setObjectValue:"),function(_7,_8,_9){
with(_7){
if(_9.editing){
row=_9.row;
objj_msgSend(button,"setTitle:","-");
objj_msgSend(button,"setFrame:",CGRectMake(0,0,24,24));
objj_msgSend(button,"setCenter:",CPPointMake(12,25));
}else{
if(_9.visible){
row=_9.row;
objj_msgSend(button,"setTitle:",">");
objj_msgSend(button,"setFrame:",CGRectMake(0,0,24,24));
objj_msgSend(button,"setCenter:",CPPointMake(12,25));
}else{
row=-1;
objj_msgSend(button,"setFrame:",CGRectMakeZero());
}
}
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
}),new objj_method(sel_getUid("setAction:"),function(_13,_14,_15){
with(_13){
}
}),new objj_method(sel_getUid("setTarget:"),function(_16,_17,_18){
with(_16){
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
p;21;ImageTextColumnView.jt;2138;@STATIC;1.0;I;15;AppKit/CPView.jt;2099;
objj_executeFile("AppKit/CPView.j",NO);
var _1=objj_allocateClassPair(CPView,"ImageTextColumnView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("textfield"),new objj_ivar("imageView")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("ImageTextColumnView").super_class},"initWithFrame:",_5);
imageView=objj_msgSend(objj_msgSend(CPImageView,"alloc"),"initWithFrame:",CGRectMake(2,2,22,22));
objj_msgSend(imageView,"setImageScaling:",CPScaleNone);
textfield=objj_msgSend(CPTextField,"labelWithTitle:","");
objj_msgSend(textfield,"setFrame:",CGRectMake(0,20,10,26));
objj_msgSend(textfield,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable|CPViewMaxYMargin|CPViewMinYMargin);
objj_msgSend(textfield,"setTextColor:",objj_msgSend(CPColor,"grayColor"));
objj_msgSend(_3,"addSubview:",imageView);
objj_msgSend(_3,"addSubview:",textfield);
return _3;
}
}),new objj_method(sel_getUid("setObjectValue:"),function(_6,_7,_8){
with(_6){
objj_msgSend(textfield,"setObjectValue:",_8);
var _9;
if(_8=="Navigation"){
_9="Resources/navigation.png";
}else{
if(_8=="Spacer"){
_9="Resources/spacer2.png";
}else{
if(_8=="Text"){
_9="Resources/text2.png";
}else{
_9="Resources/detail.png";
}
}
}
objj_msgSend(imageView,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:",_9));
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_a,_b,_c){
with(_a){
_a=objj_msgSendSuper({receiver:_a,super_class:objj_getClass("ImageTextColumnView").super_class},"initWithCoder:",_c);
textfield=objj_msgSend(_c,"decodeObjectForKey:","textfield");
imageView=objj_msgSend(_c,"decodeObjectForKey:","imageView");
return _a;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_d,_e,_f){
with(_d){
objj_msgSendSuper({receiver:_d,super_class:objj_getClass("ImageTextColumnView").super_class},"encodeWithCoder:",_f);
objj_msgSend(_f,"encodeObject:forKey:",textfield,"textfield");
objj_msgSend(_f,"encodeObject:forKey:",imageView,"imageView");
}
})]);
p;12;LoginPanel.jt;3677;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.jt;3611;
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
_8=objj_msgSend(_8,"initWithContentRect:styleMask:",CGRectMake(200,150,350,170),CPHUDBackgroundWindowMask);
if(_8){
_8.delegate=_a;
objj_msgSend(_8,"setTitle:","Private Beta Login");
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
objj_msgSend(_12,"setFrame:",CGRectMake(250,110,70,20));
objj_msgSend(_b,"addSubview:",_12);
objj_msgSend(_12,"setTag:",1);
objj_msgSend(_12,"setTarget:",_8);
objj_msgSend(_12,"setAction:",sel_getUid("buttonAction:"));
var _13=objj_msgSend(CPButton,"buttonWithTitle:theme:","Cancel",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_13,"setFrame:",CGRectMake(170,110,70,20));
objj_msgSend(_b,"addSubview:",_13);
objj_msgSend(_13,"setTag:",0);
var _14=objj_msgSend(CPButton,"buttonWithTitle:","Want to be part of the fun? Sign up.");
objj_msgSend(_14,"sizeToFit");
objj_msgSend(_14,"setFrameOrigin:",CGPointMake(80,140));
objj_msgSend(_14,"setBordered:",NO);
objj_msgSend(_14,"setTextColor:",objj_msgSend(CPColor,"grayColor"));
_14._DOMElement.style.textDecoration="underline";
objj_msgSend(_14,"setTarget:",_8);
objj_msgSend(_14,"setAction:",sel_getUid("signup"));
_14._DOMElement.style.cursor="pointer";
objj_msgSend(_b,"addSubview:",_14);
objj_msgSend(_13,"setTarget:",_8);
objj_msgSend(_13,"setAction:",sel_getUid("buttonAction:"));
}
return _8;
}
}),new objj_method(sel_getUid("buttonAction:"),function(_15,_16,_17){
with(_15){
if(objj_msgSend(delegate,"respondsToSelector:",sel_getUid("panelDidClose:"))){
objj_msgSend(delegate,"panelDidClose:",objj_msgSend(_17,"tag"));
}
objj_msgSend(_15,"close");
}
}),new objj_method(sel_getUid("signup"),function(_18,_19){
with(_18){
window.open("https://spreadsheets.google.com/viewform?formkey=dFJWN29DR09fanRfRnVic255Z1hVMEE6MQ","_self");
}
})]);
p;6;main.jt;267;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jt;181;
objj_executeFile("Foundation/Foundation.j",NO);
objj_executeFile("AppKit/AppKit.j",NO);
objj_executeFile("AppController.j",YES);
main=function(_1,_2){
CPApplicationMain(_1,_2);
};
p;13;NewTemplate.jt;2662;@STATIC;1.0;I;21;Foundation/CPObject.jt;2617;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"NewTemplate"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_2,[new objj_method(sel_getUid("data"),function(_3,_4){
with(_3){
var _5={rootpage:{type:"Navigation",title:"",children:[{type:"Detail",title:"News",subtitle:"Update: 12.12. / 9:00",children:[],attributes:[{"key":"Info","value":"This is a perfect place to put in some information about agenda changes."}]},{type:"Spacer",title:"Conference",subtitle:"",children:[]},{type:"Navigation",title:"Day 01",subtitle:"04 October, 2010",children:[{type:"Navigation",title:"Track A",subtitle:"This track is about topic X",children:[{type:"Detail",title:"A great session",subtitle:"9:00 - 10:30 in Room 1",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc:","value":"A detailed description about his session"},{"key":"Link:","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"A great session",subtitle:"11:00 - 12:30 in Room 2",attributes:[],children:[]},{type:"Detail",title:"A great session",subtitle:"14:00 - 15:30 in Room 3",attributes:[],children:[]}]},{type:"Navigation",title:"Track B",subtitle:"This track is about topic Y",children:[{type:"Detail",title:"A great session",subtitle:"9:00 - 10:30 in Room 2",attributes:[],children:[]},{type:"Detail",title:"A great session",subtitle:"11:00 - 12:30 in Room 3",attributes:[],children:[]},{type:"Detail",title:"A great session",subtitle:"14:00 - 15:30 in Room 1",attributes:[],children:[]}]}]},{type:"Navigation",title:"Day 02",subtitle:"05 October, 2010",children:[{type:"Navigation",title:"Track A",subtitle:"This track is about topic X",children:[{type:"Detail",title:"A great session",subtitle:"9:00 - 10:30 in Room 1",attributes:[],children:[]},{type:"Detail",title:"A great session",subtitle:"11:00 - 12:30 in Room 2",attributes:[],children:[]},{type:"Detail",title:"A great session",subtitle:"14:00 - 15:30 in Room 3",attributes:[],children:[]}]}]},{type:"Navigation",title:"Day 03",subtitle:"06 October, 2010",children:[{type:"Navigation",title:"Track A",subtitle:"This track is about topic X",children:[{type:"Detail",title:"A great session",subtitle:"9:00 - 10:30 in Room 1",attributes:[],children:[]},{type:"Detail",title:"A great session",subtitle:"11:00 - 12:30 in Room 2",attributes:[],children:[]},{type:"Detail",title:"A great session",subtitle:"14:00 - 15:30 in Room 3",attributes:[],children:[]}]}]},{type:"Spacer",title:"",subtitle:"",children:[]},{type:"Navigation",title:"Infos",subtitle:"General information",children:[]}]}};
return JSON.stringify(_5);
}
})]);
p;6;Page.jt;4080;@STATIC;1.0;I;21;Foundation/CPObject.jt;4035;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"Page"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("title"),new objj_ivar("subtitle"),new objj_ivar("children"),new objj_ivar("type"),new objj_ivar("attributes"),new objj_ivar("navigationId"),new objj_ivar("ancestor")]);
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
}),new objj_method(sel_getUid("type"),function(_12,_13){
with(_12){
return type;
}
}),new objj_method(sel_getUid("setType:"),function(_14,_15,_16){
with(_14){
type=_16;
}
}),new objj_method(sel_getUid("attributes"),function(_17,_18){
with(_17){
return attributes;
}
}),new objj_method(sel_getUid("setAttributes:"),function(_19,_1a,_1b){
with(_19){
attributes=_1b;
}
}),new objj_method(sel_getUid("navigationId"),function(_1c,_1d){
with(_1c){
return navigationId;
}
}),new objj_method(sel_getUid("setNavigationId:"),function(_1e,_1f,_20){
with(_1e){
navigationId=_20;
}
}),new objj_method(sel_getUid("ancestor"),function(_21,_22){
with(_21){
return ancestor;
}
}),new objj_method(sel_getUid("setAncestor:"),function(_23,_24,_25){
with(_23){
ancestor=_25;
}
}),new objj_method(sel_getUid("init"),function(_26,_27){
with(_26){
_26=objj_msgSendSuper({receiver:_26,super_class:objj_getClass("Page").super_class},"init");
children=objj_msgSend(objj_msgSend(CPArray,"alloc"),"init");
attributes=objj_msgSend(objj_msgSend(CPArray,"alloc"),"init");
type="Navigation";
navigationId="";
return _26;
}
}),new objj_method(sel_getUid("initWithTitle:andSubtitle:andType:andNavigationId:"),function(_28,_29,_2a,_2b,_2c,_2d){
with(_28){
_28=objj_msgSend(_28,"init");
title=_2a;
subtitle=_2b;
type=_2c;
navigationId=_2d;
return _28;
}
}),new objj_method(sel_getUid("addChild:atIndex:"),function(_2e,_2f,_30,_31){
with(_2e){
objj_msgSend(_30,"setAncestor:",_2e);
if(_31<0){
_31=children.length;
}
objj_msgSend(children,"insertObject:atIndex:",_30,_31);
}
}),new objj_method(sel_getUid("removeChild:"),function(_32,_33,_34){
with(_32){
objj_msgSend(children,"removeObjectAtIndex:",_34);
}
}),new objj_method(sel_getUid("toJSON"),function(_35,_36){
with(_35){
var _37="";
for(var i=0;i<children.length;i++){
_37+=objj_msgSend(children[i],"toJSON");
_37+=",";
}
if(_37.length>0){
_37=_37.substring(0,_37.length-1);
}
var _38="";
for(var i=0;i<attributes.length;i++){
_38+="{\"key\":\""+attributes[i].key+"\"";
_38+=",\"value\":\""+attributes[i].value+"\"}";
_38+=",";
}
if(_38.length>0){
_38=_38.substring(0,_38.length-1);
}
var _39="{\"title\":\""+title;
if(subtitle){
_39+="\",\"subtitle\":\""+subtitle;
}
_39+="\",\"type\":\""+type+"\",\"children\":["+_37+"],\"attributes\":["+_38+"]}";
return _39;
}
}),new objj_method(sel_getUid("description"),function(_3a,_3b){
with(_3a){
return title;
}
}),new objj_method(sel_getUid("isNavigationType"),function(_3c,_3d){
with(_3c){
return type==="Navigation";
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("initFromJSONObject:andNavigationId:"),function(_3e,_3f,_40,_41){
with(_3e){
var _42=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andNavigationId:",_40.title,_40.subtitle,_40.type,_41);
for(var i=0;i<_40.children.length;i++){
var _43=_41+"c"+i;
var _44=objj_msgSend(Page,"initFromJSONObject:andNavigationId:",_40.children[i],_43);
objj_msgSend(_42,"addChild:atIndex:",_44,-1);
}
if(_40.attributes){
for(var i=0;i<_40.attributes.length;i++){
var _45=_40.attributes[i];
console.log(_45);
objj_msgSend(objj_msgSend(_42,"attributes"),"insertObject:atIndex:",_45,i);
}
}
return _42;
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
p;20;PageViewController.jt;10463;@STATIC;1.0;I;21;Foundation/CPObject.ji;18;ButtonColumnView.ji;21;CPPropertyAnimation.ji;21;ImageTextColumnView.jt;10342;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("ButtonColumnView.j",YES);
objj_executeFile("CPPropertyAnimation.j",YES);
objj_executeFile("ImageTextColumnView.j",YES);
var _1=objj_allocateClassPair(CPViewController,"PageViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("scrollView"),new objj_ivar("page"),new objj_ivar("addButton"),new objj_ivar("backButton"),new objj_ivar("editButton"),new objj_ivar("itemtypeButton"),new objj_ivar("delegate"),new objj_ivar("table"),new objj_ivar("titleField"),new objj_ivar("editing")]);
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
table=objj_msgSend(objj_msgSend(CPTableView,"alloc"),"initWithFrame:",CGRectMake(0,0,320,650));
var _13=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","zero");
var _14=objj_msgSend(objj_msgSend(ImageTextColumnView,"alloc"),"initWithFrame:",CGRectMake(0,0,20,30));
objj_msgSend(_13,"setDataView:",_14);
objj_msgSend(objj_msgSend(_13,"headerView"),"setStringValue:","");
objj_msgSend(_13,"setWidth:",75);
objj_msgSend(_13,"setEditable:",NO);
objj_msgSend(table,"addTableColumn:",_13);
var _15=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","first");
objj_msgSend(objj_msgSend(_15,"headerView"),"setStringValue:","Title");
var _16=objj_msgSend(CPTextField,"labelWithTitle:","");
objj_msgSend(_16,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(_16,"setVerticalAlignment:",CPCenterTextAlignment);
objj_msgSend(_15,"setDataView:",_16);
objj_msgSend(_15,"setWidth:",170);
objj_msgSend(_15,"setEditable:",YES);
objj_msgSend(table,"addTableColumn:",_15);
var _17=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","second");
objj_msgSend(objj_msgSend(_17,"headerView"),"setStringValue:","Subtitle");
objj_msgSend(_17,"setWidth:",230);
objj_msgSend(_17,"setEditable:",YES);
objj_msgSend(_17,"setDataView:",_16);
objj_msgSend(table,"addTableColumn:",_17);
var _18=objj_msgSend(objj_msgSend(ButtonColumnView,"alloc"),"initWithFrame:andDelegate:",CGRectMake(0,0,10,20),_11);
var _19=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","button");
objj_msgSend(_19,"setDataView:",_18);
objj_msgSend(_19,"setWidth:",30);
objj_msgSend(_19,"setEditable:",YES);
objj_msgSend(table,"addTableColumn:",_19);
objj_msgSend(table,"setUsesAlternatingRowBackgroundColors:",YES);
objj_msgSend(table,"setAlternatingRowBackgroundColors:",[objj_msgSend(CPColor,"whiteColor"),objj_msgSend(CPColor,"colorWithHexString:","e4e7ff")]);
objj_msgSend(table,"setRowHeight:",50);
objj_msgSend(table,"setDataSource:",_11);
objj_msgSend(table,"setDelegate:",_11);
objj_msgSend(table,"setAllowsColumnSelection:",NO);
objj_msgSend(scrollView,"setDocumentView:",table);
objj_msgSend(backButton,"setEnabled:",NO);
objj_msgSend(itemtypeButton,"removeAllItems");
editing=NO;
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_11,sel_getUid("rowClicked:"),"RowClickedNotification",nil);
}
}),new objj_method(sel_getUid("setDelegate:"),function(_1a,_1b,_1c){
with(_1a){
delegate=_1c;
}
}),new objj_method(sel_getUid("tableView:shouldEditTableColumn:row:"),function(_1d,_1e,_1f,_20,row){
with(_1d){
objj_msgSend(_1d,"setEditing:",NO);
objj_msgSend(_1d,"toggleEditing:",_1f);
return YES;
}
}),new objj_method(sel_getUid("toggleEditing:"),function(_21,_22,_23){
with(_21){
var _24;
if(_21.editing){
objj_msgSend(_21,"setEditing:",NO);
objj_msgSend(editButton,"setTitle:","Edit");
objj_msgSend(editButton,"unsetThemeState:",CPThemeStateDefault);
_24=objj_msgSend(CPTextField,"labelWithTitle:","");
objj_msgSend(_24,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(_24,"setVerticalAlignment:",CPCenterTextAlignment);
}else{
objj_msgSend(_21,"setEditing:",YES);
objj_msgSend(editButton,"setTitle:","Done");
objj_msgSend(editButton,"setThemeState:",CPThemeStateDefault);
_24=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","",100);
}
var _25=objj_msgSend(table,"tableColumns");
objj_msgSend(_25[1],"setDataView:",_24);
objj_msgSend(_25[2],"setDataView:",_24);
objj_msgSend(_21,"myRefresh");
}
}),new objj_method(sel_getUid("numberOfRowsInTableView:"),function(_26,_27,_28){
with(_26){
if(objj_msgSend(page,"isNavigationType")){
return objj_msgSend(objj_msgSend(page,"children"),"count");
}else{
return objj_msgSend(objj_msgSend(page,"attributes"),"count");
}
}
}),new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"),function(_29,_2a,_2b,_2c,row){
with(_29){
if(objj_msgSend(page,"isNavigationType")){
var _2d=objj_msgSend(objj_msgSend(page,"children"),"objectAtIndex:",row);
var _2e=YES;
if(objj_msgSend(objj_msgSend(_2c,"identifier"),"isEqual:","zero")){
return _2d.type;
}else{
if(objj_msgSend(objj_msgSend(_2c,"identifier"),"isEqual:","first")){
return objj_msgSend(_2d,"title");
}else{
if(objj_msgSend(objj_msgSend(_2c,"identifier"),"isEqual:","second")){
_2e=_2d.type!=="Spacer";
return objj_msgSend(_2d,"subtitle");
}else{
_2e=_2d.type!=="Spacer";
return {row:row,visible:_2e,editing:editing};
}
}
}
}else{
var _2f=objj_msgSend(objj_msgSend(page,"attributes"),"objectAtIndex:",row);
var key=_2f.key;
var _30=_2f.value;
if(objj_msgSend(objj_msgSend(_2c,"identifier"),"isEqual:","zero")){
return "Text";
}else{
if(objj_msgSend(objj_msgSend(_2c,"identifier"),"isEqual:","first")){
return key;
}else{
if(objj_msgSend(objj_msgSend(_2c,"identifier"),"isEqual:","second")){
return _30;
}else{
return {visible:NO,row:row,editing:editing};
}
}
}
}
}
}),new objj_method(sel_getUid("tableView:setObjectValue:forTableColumn:row:"),function(_31,_32,_33,_34,_35,row){
with(_31){
if(objj_msgSend(page,"isNavigationType")){
var _36=objj_msgSend(objj_msgSend(page,"children"),"objectAtIndex:",row);
if(objj_msgSend(objj_msgSend(_35,"identifier"),"isEqual:","first")){
objj_msgSend(_36,"setTitle:",_34);
}else{
objj_msgSend(_36,"setSubtitle:",_34);
}
}else{
var _37=objj_msgSend(objj_msgSend(page,"attributes"),"objectAtIndex:",row);
if(objj_msgSend(objj_msgSend(_35,"identifier"),"isEqual:","first")){
_37.key=_34;
}else{
_37.value=_34;
}
}
objj_msgSend(table,"reloadData");
}
}),new objj_method(sel_getUid("tableView:isGroupRow:"),function(_38,_39,_3a,row){
with(_38){
console.log("isGroupRow:"+row);
return YES;
}
}),new objj_method(sel_getUid("addItemToList:"),function(_3b,_3c,_3d){
with(_3b){
if(objj_msgSend(page,"isNavigationType")){
var _3e=objj_msgSend(objj_msgSend(itemtypeButton,"selectedItem"),"title");
var _3f;
var _40=objj_msgSend(table,"selectedRow");
var _41=page.navigationId+"c"+_40;
if(_3e=="Navigationpage"){
_3f=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andNavigationId:","The title of a subpage","The optional subtitle of a subpage","Navigation",_41);
}else{
if(_3e=="Detailpage"){
_3f=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andNavigationId:","The title of a subpage","The optional subtitle of a subpage","Detail",_41);
}else{
_3f=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andNavigationId:","A group title","","Spacer",_41);
}
}
objj_msgSend(page,"addChild:atIndex:",_3f,_40);
}else{
var _42={key:"A key",value:"A value"};
objj_msgSend(objj_msgSend(page,"attributes"),"insertObject:atIndex:",_42,objj_msgSend(table,"selectedRow"));
}
objj_msgSend(table,"reloadData");
}
}),new objj_method(sel_getUid("deleteItemFromList:"),function(_43,_44,row){
with(_43){
if(objj_msgSend(page,"isNavigationType")){
objj_msgSend(page,"removeChild:",row);
}else{
objj_msgSend(objj_msgSend(page,"attributes"),"removeObjectAtIndex:",row);
}
objj_msgSend(table,"deselectAll");
objj_msgSend(table,"reloadData");
}
}),new objj_method(sel_getUid("rowClicked:"),function(_45,_46,_47){
with(_45){
if(!objj_msgSend(_45,"editing")){
var row=objj_msgSend(_47,"object");
page=objj_msgSend(objj_msgSend(page,"children"),"objectAtIndex:",row);
objj_msgSend(objj_msgSend(CPPropertyAnimation,"slideLeft:view:",_45,scrollView),"startAnimation");
objj_msgSend(delegate,"selectedPage:reverse:",page,NO);
objj_msgSend(_45,"myRefresh");
}else{
objj_msgSend(_45,"deleteItemFromList:",objj_msgSend(_47,"object"));
}
}
}),new objj_method(sel_getUid("animationDidEnd:"),function(_48,_49,_4a){
with(_48){
console.log("animationDidEnd");
}
}),new objj_method(sel_getUid("backButtonClicked:"),function(_4b,_4c,_4d){
with(_4b){
objj_msgSend(objj_msgSend(CPPropertyAnimation,"slideRight:view:",_4b,scrollView),"startAnimation");
page=objj_msgSend(page,"ancestor");
objj_msgSend(delegate,"selectedPage:reverse:",page,YES);
objj_msgSend(_4b,"myRefresh");
}
}),new objj_method(sel_getUid("myRefresh"),function(_4e,_4f){
with(_4e){
objj_msgSend(table,"reloadData");
objj_msgSend(backButton,"setEnabled:",page.ancestor!=null);
objj_msgSend(table,"deselectAll");
var _50=page.title;
if(page.subtitle!=null){
_50+=" / "+page.subtitle;
}
if(page.title){
_50+=" ("+page.type+")";
}
objj_msgSend(titleField,"setObjectValue:",_50);
objj_msgSend(itemtypeButton,"removeAllItems");
var _51=objj_msgSend(objj_msgSend(table,"tableColumns")[0],"headerView");
var _52=objj_msgSend(objj_msgSend(table,"tableColumns")[1],"headerView");
var _53=objj_msgSend(objj_msgSend(table,"tableColumns")[2],"headerView");
objj_msgSend(_51,"setStringValue:","Type");
if(objj_msgSend(page,"isNavigationType")){
objj_msgSend(_52,"setStringValue:","Title");
objj_msgSend(_53,"setStringValue:","Subtitle");
objj_msgSend(itemtypeButton,"addItemsWithTitles:",["Navigationpage","Detailpage","Spacer"]);
}else{
objj_msgSend(_52,"setStringValue:","Attribute");
objj_msgSend(_53,"setStringValue:","Value");
objj_msgSend(itemtypeButton,"addItemsWithTitles:",["Text","Link","Tweeter"]);
}
}
})]);
p;21;TextFieldColumnView.jt;1171;@STATIC;1.0;I;15;AppKit/CPView.jt;1132;
objj_executeFile("AppKit/CPView.j",NO);
var _1=objj_allocateClassPair(CPTextField,"TextFieldColumnView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("TextFieldColumnView").super_class},"initWithFrame:",_5);
objj_msgSend(_3,"setLineBreakMode:",CPLineBreakByTruncatingTail);
objj_msgSend(_3,"setValue:forThemeAttribute:",objj_msgSend(CPColor,"colorWithHexString:","333333"),"text-color");
objj_msgSend(_3,"setValue:forThemeAttribute:inState:",objj_msgSend(CPColor,"whiteColor"),"text-color",CPThemeStateSelected);
objj_msgSend(_3,"setValue:forThemeAttribute:inState:",objj_msgSend(CPFont,"boldSystemFontOfSize:",12),"font",CPThemeStateSelected);
objj_msgSend(_3,"setValue:forThemeAttribute:",CPCenterVerticalTextAlignment,"vertical-alignment");
return _3;
}
}),new objj_method(sel_getUid("setObjectValue:"),function(_6,_7,_8){
with(_6){
var s=_8?_8.title:"";
objj_msgSendSuper({receiver:_6,super_class:objj_getClass("TextFieldColumnView").super_class},"setObjectValue:",s);
}
})]);
e;