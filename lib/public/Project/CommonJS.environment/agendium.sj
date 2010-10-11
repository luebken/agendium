@STATIC;1.0;p;20;AgendiumConnection.jt;4944;@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;8;Config.jt;4877;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("Page.j",YES);
objj_executeFile("Config.j",YES);
var _1=objj_allocateClassPair(CPObject,"AgendiumConnection"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("listConnection"),new objj_ivar("listDelegate"),new objj_ivar("saveConnection"),new objj_ivar("saveDelegate"),new objj_ivar("loginConnection"),new objj_ivar("loginDelegate"),new objj_ivar("checkNameConnection"),new objj_ivar("checkNameDelegate")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("init"),function(_3,_4){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("AgendiumConnection").super_class},"init");
return _3;
}
}),new objj_method(sel_getUid("loadAgendaFor:andName:withDelegate:"),function(_5,_6,_7,_8,_9){
with(_5){
var _a=objj_msgSend(CPURLRequest,"requestWithURL:",BASEURL+"agenda/"+_7+"/"+_8);
objj_msgSend(_a,"setHTTPMethod:","GET");
listConnection=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_a,_5);
listDelegate=_9;
}
}),new objj_method(sel_getUid("checkUser:withPassword:delegate:"),function(_b,_c,_d,_e,_f){
with(_b){
var _10=objj_msgSend(CPURLRequest,"requestWithURL:",BASEURL+"user/"+_d+"/"+_e);
objj_msgSend(_10,"setHTTPMethod:","GET");
loginConnection=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_10,_b);
loginDelegate=_f;
}
}),new objj_method(sel_getUid("saveAgenda:rootPage:userid:delegate:"),function(_11,_12,_13,_14,_15,_16){
with(_11){
var _17=objj_msgSend(CPURLRequest,"requestWithURL:",BASEURL+"agenda");
objj_msgSend(_17,"setHTTPMethod:","POST");
var _18="{\"_id\":\""+_13+"\",\"userid\":\""+_15+"\", \"rootpage\":"+objj_msgSend(_14,"toJSON")+"}";
objj_msgSend(_17,"setHTTPBody:",_18);
objj_msgSend(_17,"setValue:forHTTPHeaderField:","application/json","Accept");
objj_msgSend(_17,"setValue:forHTTPHeaderField:","application/json","Content-Type");
saveConnection=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_17,_11);
saveDelegate=_16;
}
}),new objj_method(sel_getUid("checkAppName:forId:delegate:"),function(_19,_1a,_1b,id,_1c){
with(_19){
var _1d=objj_msgSend(CPURLRequest,"requestWithURL:",BASEURL+"isnameok/"+_1b+"/"+id);
objj_msgSend(_1d,"setHTTPMethod:","GET");
checkNameConnection=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_1d,_19);
checkNameDelegate=_1c;
}
}),new objj_method(sel_getUid("connection:didReceiveData:"),function(_1e,_1f,_20,_21){
with(_1e){
if(_20==saveConnection){
objj_msgSend(_1e,"didReceiveSaveData:delegate:",_21,saveDelegate);
}
if(_20==listConnection){
objj_msgSend(_1e,"didReceiveLoadData:delegate:",_21,listDelegate);
}
if(_20==loginConnection){
objj_msgSend(_1e,"didReceiveLoginData:delegate:",_21,loginDelegate);
}
if(_20==checkNameConnection){
objj_msgSend(_1e,"didReceiveCheckNameData:delegate:",_21,checkNameDelegate);
}
}
}),new objj_method(sel_getUid("connection:didFailWithError:"),function(_22,_23,_24,_25){
with(_22){
CPLog("didFailWithError: "+_25);
alert(_25);
}
}),new objj_method(sel_getUid("connection:didReceiveResponse:"),function(_26,_27,_28,_29){
with(_26){
CPLog("didReceiveResponse for URL:"+objj_msgSend(_29,"URL"));
}
}),new objj_method(sel_getUid("connection:didFailWithError:"),function(_2a,_2b,_2c,_2d){
with(_2a){
CPLog("didFailWithError: "+_2d);
alert(_2d);
}
}),new objj_method(sel_getUid("connection:didReceiveResponse:"),function(_2e,_2f,_30,_31){
with(_2e){
CPLog("didReceiveResponse for URL:"+objj_msgSend(_31,"URL"));
}
}),new objj_method(sel_getUid("didReceiveSaveData:delegate:"),function(_32,_33,_34,_35){
with(_32){
if(_34!=null&&_34!=""&&_34!="null"){
try{
var obj=JSON.parse(_34);
objj_msgSend(_35,"didReceiveAgenda:",obj._id);
}
catch(e){
objj_msgSend(_35,"failureWhileReceivingAgenda:","Error while parsing Data: "+e);
}
}else{
if(console){
console.log("failureWhileReceivingAgenda");
}
objj_msgSend(_35,"failureWhileReceivingAgenda:","Couldn't find the Agenda");
}
}
}),new objj_method(sel_getUid("didReceiveLoadData:delegate:"),function(_36,_37,_38,_39){
with(_36){
if(_38!=null&&_38!=""&&_38!="null"){
try{
var obj=JSON.parse(_38);
var _3a=objj_msgSend(Page,"initFromJSONObject:andNavigationId:",obj.rootpage,"r");
objj_msgSend(_39,"didReceiveAgenda:withRootPage:",obj._id,_3a);
}
catch(e){
objj_msgSend(_39,"failureWhileReceivingAgenda:","Error while parsing Data: "+e);
}
}else{
if(console){
console.log("failureWhileReceivingAgenda");
}
objj_msgSend(_39,"failureWhileReceivingAgenda:","Couldn't find the Agenda");
}
}
}),new objj_method(sel_getUid("didReceiveLoginData:delegate:"),function(_3b,_3c,_3d,_3e){
with(_3b){
if(_3d&&_3d!="undefined"){
var obj=JSON.parse(_3d);
objj_msgSend(_3e,"loginSuccess:",obj._id);
}else{
objj_msgSend(_3e,"loginFailed");
}
}
}),new objj_method(sel_getUid("didReceiveCheckNameData:delegate:"),function(_3f,_40,_41,_42){
with(_3f){
objj_msgSend(_42,"didReceiveCheckName:",_41);
}
})]);
p;15;AppController.jt;9305;@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;10;PageView.ji;20;PageViewController.ji;12;LoginPanel.ji;11;OpenPanel.ji;12;SharePanel.ji;10;NewPanel.ji;13;NewTemplate.ji;20;AgendiumConnection.ji;8;Config.jt;9090;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("Page.j",YES);
objj_executeFile("PageView.j",YES);
objj_executeFile("PageViewController.j",YES);
objj_executeFile("LoginPanel.j",YES);
objj_executeFile("OpenPanel.j",YES);
objj_executeFile("SharePanel.j",YES);
objj_executeFile("NewPanel.j",YES);
objj_executeFile("NewTemplate.j",YES);
objj_executeFile("AgendiumConnection.j",YES);
objj_executeFile("Config.j",YES);
var _1=objj_allocateClassPair(CPObject,"AppController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("theWindow"),new objj_ivar("box"),new objj_ivar("saveButton"),new objj_ivar("loadButton"),new objj_ivar("previewButton"),new objj_ivar("logoutButton"),new objj_ivar("shareButton"),new objj_ivar("previewView"),new objj_ivar("rootPage"),new objj_ivar("appnameField"),new objj_ivar("appnameProblemLabel"),new objj_ivar("buildDateLabel"),new objj_ivar("pageView"),new objj_ivar("pageViewController"),new objj_ivar("appId"),new objj_ivar("userid"),new objj_ivar("nameOKServer"),new objj_ivar("aConnection"),new objj_ivar("validName"),new objj_ivar("namechanged")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("applicationDidFinishLaunching:"),function(_3,_4,_5){
with(_3){
objj_msgSend(theWindow,"orderOut:",_3);
objj_msgSend(objj_msgSend(objj_msgSend(LoginPanel,"alloc"),"init:",_3),"orderFront:",nil);
}
}),new objj_method(sel_getUid("awakeFromCib"),function(_6,_7){
with(_6){
objj_msgSend(box,"setBorderType:",CPLineBorder);
objj_msgSend(box,"setBorderWidth:",1);
objj_msgSend(box,"setBorderColor:",objj_msgSend(CPColor,"grayColor"));
pageViewController=objj_msgSend(objj_msgSend(PageViewController,"alloc"),"initWithCibName:bundle:","PageView",nil);
objj_msgSend(pageViewController,"setPage:",rootPage);
objj_msgSend(pageViewController,"setDelegate:",_6);
objj_msgSend(objj_msgSend(pageViewController,"view"),"setFrame:",CPRectMake(1,1,550,501));
objj_msgSend(pageView,"addSubview:",objj_msgSend(pageViewController,"view"));
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_6,sel_getUid("pageDidChange:"),"PageChangedNotification",rootPage);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_6,sel_getUid("save:"),"AddItemToListNotification",nil);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_6,sel_getUid("save:"),"EditingDoneNotification",nil);
objj_msgSend(previewButton,"setBordered:",NO);
previewButton._DOMElement.style.textDecoration="underline";
objj_msgSend(previewButton,"setTextColor:",objj_msgSend(CPColor,"blueColor"));
objj_msgSend(previewButton,"setAlignment:",CPLeftTextAlignment);
objj_msgSend(previewButton,"setTarget:",_6);
objj_msgSend(previewButton,"setAction:",sel_getUid("openMobileApp"));
previewButton._DOMElement.style.cursor="pointer";
objj_msgSend(previewView,"setFrame:",CPRectMake(540,100,340,520));
objj_msgSend(previewView,"setFrameLoadDelegate:",_6);
previewView._DOMElement.style.webkitTransformOrigin="10 10";
previewView._DOMElement.style.webkitTransform="scale(0.75)";
objj_msgSend(logoutButton,"setBordered:",NO);
objj_msgSend(logoutButton,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:","Resources/logout2.png"));
logoutButton._DOMElement.style.textDecoration="underline";
logoutButton._DOMElement.style.cursor="pointer";
objj_msgSend(appnameProblemLabel,"setObjectValue:","");
aConnection=objj_msgSend(objj_msgSend(AgendiumConnection,"alloc"),"init");
objj_msgSend(appnameField,"setValue:forThemeAttribute:inState:",objj_msgSend(CPColor,"lightGrayColor"),"text-color",CPTextFieldStatePlaceholder);
objj_msgSend(buildDateLabel,"setObjectValue:",BUILDDATE);
objj_msgSend(_6,"resetData");
objj_msgSend(_6,"didReceiveAgenda:",undefined);
}
}),new objj_method(sel_getUid("pageDidChange:"),function(_8,_9,_a){
with(_8){
objj_msgSend(saveButton,"setEnabled:",rootPage.title.length>0);
}
}),new objj_method(sel_getUid("controlTextDidChange:"),function(_b,_c,_d){
with(_b){
namechanged=true;
var _e=objj_msgSend(appnameField,"objectValue");
var _f=objj_msgSend(objj_msgSend(appnameField,"objectValue"),"length");
var _10=/\s/.test(_e);
validName=!(_10|_f<5);
objj_msgSend(rootPage,"setTitle:",objj_msgSend(appnameField,"objectValue"));
objj_msgSend(_b,"refreshUIFromData");
if(validName){
objj_msgSend(aConnection,"checkAppName:forId:delegate:",_e,appId,_b);
}
}
}),new objj_method(sel_getUid("selectedPage:reverse:"),function(_11,_12,_13,_14){
with(_11){
var cmd="jQT.goTo(\"#"+_13.navigationId+"\", \"slide\"";
if(_14){
cmd+=", \"reverse\"";
}
cmd+=");";
if(console){
console.log("cmd "+cmd);
}
objj_msgSend(objj_msgSend(previewView,"windowScriptObject"),"evaluateWebScript:",cmd);
}
}),new objj_method(sel_getUid("refreshUIFromData"),function(_15,_16){
with(_15){
objj_msgSend(saveButton,"setEnabled:",validName&&nameOKServer==="true");
objj_msgSend(shareButton,"setEnabled:",validName&&nameOKServer==="true");
if(!validName){
var _17=/\s/.test(rootPage.title);
if(_17){
objj_msgSend(appnameProblemLabel,"setObjectValue:","< Please remove whitespaces.");
}else{
if(rootPage.title.length<5){
objj_msgSend(appnameProblemLabel,"setObjectValue:","");
}else{
objj_msgSend(appnameProblemLabel,"setObjectValue:","");
}
}
}else{
if(nameOKServer==="false"){
objj_msgSend(appnameProblemLabel,"setObjectValue:","< Name is already taken.");
}else{
objj_msgSend(appnameProblemLabel,"setObjectValue:","");
}
}
objj_msgSend(pageViewController,"myRefresh");
if(appId){
var _18=BASEURL+"a/"+rootPage.title;
var _19=BASEURL+"prev/"+appId;
objj_msgSend(previewView,"setMainFrameURL:",_19);
objj_msgSend(previewButton,"setTitle:",_18);
objj_msgSend(previewButton,"sizeToFit");
}else{
objj_msgSend(previewButton,"setTitle:","");
objj_msgSend(previewView,"setMainFrameURL:",BASEURL+"preview");
}
}
}),new objj_method(sel_getUid("resetData"),function(_1a,_1b){
with(_1a){
rootPage=objj_msgSend(objj_msgSend(Page,"alloc"),"init");
objj_msgSend(rootPage,"setTitle:",objj_msgSend(appnameField,"objectValue"));
rootPage.navigationId="r";
pageViewController.page=rootPage;
appId=null;
objj_msgSend(_1a,"controlTextDidChange:",null);
}
}),new objj_method(sel_getUid("openMobileApp"),function(_1c,_1d){
with(_1c){
if(namechanged){
window.alert("Please save before opening the app.");
}else{
var _1e=BASEURL+"a/"+rootPage.title;
window.open(_1e,"mywindow");
}
}
}),new objj_method(sel_getUid("load:"),function(_1f,_20,_21){
with(_1f){
var _22=objj_msgSend(appnameField,"objectValue");
objj_msgSend(objj_msgSend(objj_msgSend(OpenPanel,"alloc"),"initWithName:andDelegate:",_22,_1f),"orderFront:",nil);
}
}),new objj_method(sel_getUid("login:"),function(_23,_24,_25){
with(_23){
history.go(-1);
}
}),new objj_method(sel_getUid("new:"),function(_26,_27,_28){
with(_26){
objj_msgSend(objj_msgSend(objj_msgSend(NewPanel,"alloc"),"init:",_26),"orderFront:",nil);
}
}),new objj_method(sel_getUid("save:"),function(_29,_2a,_2b){
with(_29){
if(validName&&nameOKServer==="true"){
objj_msgSend(aConnection,"saveAgenda:rootPage:userid:delegate:",appId,rootPage,userid,_29);
}
}
}),new objj_method(sel_getUid("share:"),function(_2c,_2d,_2e){
with(_2c){
objj_msgSend(objj_msgSend(objj_msgSend(SharePanel,"alloc"),"init:andAppname:",_2c,rootPage.title),"orderFront:",nil);
}
}),new objj_method(sel_getUid("didReceiveAgenda:withRootPage:"),function(_2f,_30,_31,_32){
with(_2f){
_2f.namechanged=false;
objj_msgSend(appnameField,"setObjectValue:",_32.title);
_2f.appId=_31;
_2f.rootPage=_32;
objj_msgSend(pageViewController,"setPage:",_32);
objj_msgSend(_2f,"refreshUIFromData");
}
}),new objj_method(sel_getUid("didReceiveAgenda:"),function(_33,_34,_35){
with(_33){
_33.namechanged=false;
_33.appId=_35;
objj_msgSend(_33,"refreshUIFromData");
}
}),new objj_method(sel_getUid("didReceiveCheckName:"),function(_36,_37,_38){
with(_36){
_36.nameOKServer=_38;
objj_msgSend(_36,"refreshUIFromData");
}
}),new objj_method(sel_getUid("webView:didFinishLoadForFrame:"),function(_39,_3a,_3b,_3c){
with(_39){
}
}),new objj_method(sel_getUid("failureWhileReceivingAgenda:"),function(_3d,_3e,msg){
with(_3d){
alert(msg);
objj_msgSend(_3d,"resetData");
objj_msgSend(_3d,"refreshUIFromData");
}
}),new objj_method(sel_getUid("panelDidClose:data:"),function(_3f,_40,tag,_41){
with(_3f){
if(tag==="login"){
_3f.userid=_41;
objj_msgSend(theWindow,"orderFront:",_3f);
}
if(tag==="open"){
CPLog("Loading Agenda for "+_3f.userid+" and name "+_41);
objj_msgSend(aConnection,"loadAgendaFor:andName:withDelegate:",_3f.userid,_41,_3f);
}
if(tag==="empty"){
objj_msgSend(appnameField,"setObjectValue:","");
objj_msgSend(_3f,"resetData");
objj_msgSend(_3f,"didReceiveAgenda:",undefined);
}
if(tag==="threedaytwotracks"||tag==="onedayonetrack"){
objj_msgSend(appnameField,"setObjectValue:","");
objj_msgSend(_3f,"resetData");
var obj=JSON.parse(objj_msgSend(NewTemplate,"jsonDataForTemplate:withStartingDate:",tag,_41));
var _42=objj_msgSend(Page,"initFromJSONObject:andNavigationId:",obj.rootpage,"r");
objj_msgSend(_3f,"didReceiveAgenda:withRootPage:",undefined,_42);
}
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
p;12;Config-dev.jt;75;@STATIC;1.0;t;58;
BASEURL="http://localhost:8000/";
BUILDDATE="vDEVBUILD";
p;13;Config-prod.jt;50;@STATIC;1.0;t;33;
BASEURL="http://touchium.com/";
p;8;Config.jt;82;@STATIC;1.0;t;65;
BASEURL="http://touchium.com/";
BUILDDATE="v20101011-17:50:23";
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
p;12;LoginPanel.jt;4582;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.jt;4516;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("AppKit/CPPanel.j",NO);
var _1=objj_allocateClassPair(CPPanel,"LoginPanel"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("titleLabel"),new objj_ivar("emailField"),new objj_ivar("passwordField"),new objj_ivar("aConnection")]);
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
_8=objj_msgSend(_8,"initWithContentRect:styleMask:",CGRectMake(250,150,350,170),CPHUDBackgroundWindowMask);
if(_8){
_8.delegate=_a;
objj_msgSend(_8,"setTitle:","Private Beta Login");
objj_msgSend(_8,"setFloatingPanel:",YES);
var _b=objj_msgSend(_8,"contentView"),_c=objj_msgSend(_b,"bounds");
titleLabel=objj_msgSend(CPTextField,"labelWithTitle:","Enter your email and password to login.");
objj_msgSend(titleLabel,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(titleLabel,"sizeToFit");
objj_msgSend(titleLabel,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(titleLabel,"setFrameOrigin:",CGPointMake(45,5));
objj_msgSend(_b,"addSubview:",titleLabel);
var _d=objj_msgSend(CPTextField,"labelWithTitle:","Email:");
objj_msgSend(_d,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_d,"setFrameOrigin:",CGPointMake(62,40));
objj_msgSend(_b,"addSubview:",_d);
emailField=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","",200);
objj_msgSend(emailField,"setFrameOrigin:",CGPointMake(100,35));
objj_msgSend(_b,"addSubview:",emailField);
var _e=objj_msgSend(CPTextField,"labelWithTitle:","Password:");
objj_msgSend(_e,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_e,"setFrameOrigin:",CGPointMake(40,70));
objj_msgSend(_b,"addSubview:",_e);
passwordField=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","",200);
objj_msgSend(passwordField,"setFrameOrigin:",CGPointMake(100,65));
objj_msgSend(passwordField,"setSecure:",YES);
objj_msgSend(_b,"addSubview:",passwordField);
var _f=objj_msgSend(CPButton,"buttonWithTitle:theme:","Login",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_f,"setFrame:",CGRectMake(250,110,70,20));
objj_msgSend(_b,"addSubview:",_f);
objj_msgSend(_f,"setTag:","login");
objj_msgSend(_f,"setTarget:",_8);
objj_msgSend(_f,"setAction:",sel_getUid("buttonAction:"));
var _10=objj_msgSend(CPButton,"buttonWithTitle:theme:","Cancel",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_10,"setFrame:",CGRectMake(170,110,70,20));
objj_msgSend(_b,"addSubview:",_10);
objj_msgSend(_10,"setTag:","logincancel");
var _11=objj_msgSend(CPButton,"buttonWithTitle:","Want to be part of the fun? Sign up.");
objj_msgSend(_11,"sizeToFit");
objj_msgSend(_11,"setFrameOrigin:",CGPointMake(80,140));
objj_msgSend(_11,"setBordered:",NO);
objj_msgSend(_11,"setTextColor:",objj_msgSend(CPColor,"grayColor"));
_11._DOMElement.style.textDecoration="underline";
objj_msgSend(_11,"setTarget:",_8);
objj_msgSend(_11,"setAction:",sel_getUid("signup"));
_11._DOMElement.style.cursor="pointer";
objj_msgSend(_b,"addSubview:",_11);
objj_msgSend(_10,"setTarget:",_8);
objj_msgSend(_10,"setAction:",sel_getUid("buttonAction:"));
aConnection=objj_msgSend(objj_msgSend(AgendiumConnection,"alloc"),"init");
}
return _8;
}
}),new objj_method(sel_getUid("buttonAction:"),function(_12,_13,_14){
with(_12){
if(objj_msgSend(_14,"tag")=="login"){
if(console){
console.log("trying to login "+objj_msgSend(emailField,"objectValue"));
}
objj_msgSend(aConnection,"checkUser:withPassword:delegate:",objj_msgSend(emailField,"objectValue"),objj_msgSend(passwordField,"objectValue"),_12);
}else{
if(objj_msgSend(_14,"tag")=="logincancel"){
history.go(-1);
objj_msgSend(_12,"close");
}
}
}
}),new objj_method(sel_getUid("loginSuccess:"),function(_15,_16,_17){
with(_15){
if(objj_msgSend(delegate,"respondsToSelector:",sel_getUid("panelDidClose:data:"))){
objj_msgSend(delegate,"panelDidClose:data:","login",_17);
objj_msgSend(_15,"close");
}
}
}),new objj_method(sel_getUid("loginFailed"),function(_18,_19){
with(_18){
objj_msgSend(titleLabel,"setObjectValue:","Login failed. Please try again.");
}
}),new objj_method(sel_getUid("signup"),function(_1a,_1b){
with(_1a){
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
p;10;NewPanel.jt;3646;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.ji;23;DatePicker/DatePicker.jt;3552;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("AppKit/CPPanel.j",NO);
objj_executeFile("DatePicker/DatePicker.j",YES);
var _1=objj_allocateClassPair(CPPanel,"NewPanel"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("theDatePicker")]);
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
_8=objj_msgSend(_8,"initWithContentRect:styleMask:",CGRectMake(200,110,310,160),CPHUDBackgroundWindowMask);
if(_8){
_8.delegate=_a;
objj_msgSend(_8,"setTitle:","New Agenda");
objj_msgSend(_8,"setFloatingPanel:",YES);
var _b=objj_msgSend(_8,"contentView"),_c=objj_msgSend(_b,"bounds");
var _d=objj_msgSend(CPTextField,"labelWithTitle:","Starting date:");
objj_msgSend(_d,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(_d,"sizeToFit");
objj_msgSend(_d,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_d,"setFrameOrigin:",CGPointMake(30,15));
objj_msgSend(_b,"addSubview:",_d);
theDatePicker=objj_msgSend(objj_msgSend(DatePicker,"alloc"),"initWithFrame:",CGRectMake(120,10,100,30));
objj_msgSend(theDatePicker,"displayPreset:",1);
objj_msgSend(theDatePicker,"setDelegate:",_8);
var _e=objj_msgSend(CPTextField,"labelWithTitle:","Choose your agenda template:");
objj_msgSend(_e,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(_e,"sizeToFit");
objj_msgSend(_e,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_e,"setFrameOrigin:",CGPointMake(30,50));
objj_msgSend(_b,"addSubview:",_e);
var _f=objj_msgSend(CPButton,"buttonWithTitle:theme:","1 day 1 track",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_f,"setFrame:",CGRectMake(30,80,110,20));
objj_msgSend(_b,"addSubview:",_f);
objj_msgSend(_f,"setTag:","onedayonetrack");
objj_msgSend(_f,"setTarget:",_8);
objj_msgSend(_f,"setAction:",sel_getUid("buttonAction:"));
var _10=objj_msgSend(CPButton,"buttonWithTitle:theme:","3 days 2 tracks",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_10,"setFrame:",CGRectMake(170,80,110,20));
objj_msgSend(_b,"addSubview:",_10);
objj_msgSend(_10,"setTag:","threedaytwotracks");
objj_msgSend(_10,"setTarget:",_8);
objj_msgSend(_10,"setAction:",sel_getUid("buttonAction:"));
var _11=objj_msgSend(CPButton,"buttonWithTitle:theme:","Empty",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_11,"setFrame:",CGRectMake(30,110,110,20));
objj_msgSend(_b,"addSubview:",_11);
objj_msgSend(_11,"setTag:","empty");
objj_msgSend(_11,"setTarget:",_8);
objj_msgSend(_11,"setAction:",sel_getUid("buttonAction:"));
var _12=objj_msgSend(CPButton,"buttonWithTitle:theme:","Cancel",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_12,"setFrame:",CGRectMake(170,110,110,20));
objj_msgSend(_b,"addSubview:",_12);
objj_msgSend(_12,"setTag:","cancel");
objj_msgSend(_12,"setTarget:",_8);
objj_msgSend(_12,"setAction:",sel_getUid("buttonAction:"));
objj_msgSend(_b,"addSubview:",theDatePicker);
}
return _8;
}
}),new objj_method(sel_getUid("datePickerDidChange:"),function(_13,_14,_15){
with(_13){
var _16=objj_msgSend(objj_msgSend(_15,"object"),"date");
}
}),new objj_method(sel_getUid("buttonAction:"),function(_17,_18,_19){
with(_17){
objj_msgSend(delegate,"panelDidClose:data:",objj_msgSend(_19,"tag"),objj_msgSend(theDatePicker,"date"));
objj_msgSend(_17,"close");
}
})]);
p;13;NewTemplate.jt;10202;@STATIC;1.0;I;21;Foundation/CPObject.jt;10156;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"NewTemplate"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_2,[new objj_method(sel_getUid("stantardDateFormat:"),function(_3,_4,dt){
with(_3){
return objj_msgSend(CPString,"stringWithFormat:","%02d.%02d.%04d",dt.getDate(),dt.getMonth()+1,dt.getFullYear());
}
}),new objj_method(sel_getUid("dateFormatForUpdate:"),function(_5,_6,dt){
with(_5){
return objj_msgSend(CPString,"stringWithFormat:","Update: %02d.%02d.",dt.getDate(),dt.getMonth()+1);
}
}),new objj_method(sel_getUid("jsonDataForTemplate:withStartingDate:"),function(_7,_8,_9,_a){
with(_7){
if(_9=="onedayonetrack"){
return objj_msgSend(NewTemplate,"dataonedayonetrack:withFirstDate:",new Date(),_a);
}else{
return objj_msgSend(NewTemplate,"datathreedaystwotracks:withFirstDate:",new Date(),_a);
}
}
}),new objj_method(sel_getUid("dataonedayonetrack:withFirstDate:"),function(_b,_c,_d,_e){
with(_b){
var _f=objj_msgSend(NewTemplate,"stantardDateFormat:",_e);
var _10=objj_msgSend(NewTemplate,"dateFormatForUpdate:",_d);
var _11={rootpage:{type:"Navigation",title:"",children:[{type:"Detail",title:"News",subtitle:_10,children:[],attributes:[{"key":"Info","value":"This is a perfect place to put in some information about agenda changes."}]},{type:"Spacer",title:"Conference",subtitle:"",children:[]},{type:"Navigation",title:"Sessions",subtitle:_f,children:[{type:"Detail",title:"A great session",subtitle:"9:00 - 10:30 in Room 1",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"A great session",subtitle:"11:00 - 12:30 in Room 2",attributes:[],children:[]},{type:"Detail",title:"A great session",subtitle:"14:00 - 15:30 in Room 3",attributes:[],children:[]}]},{type:"Spacer",title:"",subtitle:"",children:[]},{type:"Navigation",title:"Infos",subtitle:"General information",children:[]}]}};
return JSON.stringify(_11);
}
}),new objj_method(sel_getUid("datathreedaystwotracks:withFirstDate:"),function(_12,_13,now,_14){
with(_12){
var _15=objj_msgSend(NewTemplate,"stantardDateFormat:",_14);
_14.setDate(_14.getDate()+1);
var _16=objj_msgSend(NewTemplate,"stantardDateFormat:",_14);
_14.setDate(_14.getDate()+1);
var _17=objj_msgSend(NewTemplate,"stantardDateFormat:",_14);
var _18=objj_msgSend(NewTemplate,"dateFormatForUpdate:",now);
var _19={rootpage:{type:"Navigation",title:"",children:[{type:"Detail",title:"News",subtitle:_18,children:[],attributes:[{"key":"Info","value":"This is a perfect place to put in some information about agenda changes."}]},{type:"Spacer",title:"Conference",subtitle:"",children:[]},{type:"Navigation",title:"Day 01",subtitle:_15,children:[{type:"Spacer",title:"Morning",subtitle:"",children:[]},{type:"Detail",title:"First Session",subtitle:"Track A | 9:00-10:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Second Session",subtitle:"Track B | 9:00-10:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Third Session",subtitle:"Track A | 10:45-11:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Fourth Session",subtitle:"Track B | 10:45-11:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Lunch",subtitle:"11:30-13:00",attributes:[{"key":"Location","value":"Get great food and drinks down in the main area."},{"key":"Exhibition","value":"Walk around the exhibition and meet great people."}],children:[]},{type:"Spacer",title:"Afternoon",subtitle:"",children:[]},{type:"Detail",title:"Fifth Session",subtitle:"Track A | 13:00-14:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Sixth Session",subtitle:"Track B | 13:00-14:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Seventh Session",subtitle:"Track A | 15:00-16:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Eigth Session",subtitle:"Track B | 15:00-16:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},]},{type:"Navigation",title:"Day 02",subtitle:_16,children:[{type:"Spacer",title:"Morning",subtitle:"",children:[]},{type:"Detail",title:"First Session",subtitle:"Track A | 9:00-10:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Second Session",subtitle:"Track B | 9:00-10:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Third Session",subtitle:"Track A | 10:45-11:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Fourth Session",subtitle:"Track B | 10:45-11:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Lunch",subtitle:"11:30-13:00",attributes:[{"key":"Location","value":"Get great food and drinks down in the main area."},{"key":"Exhibition","value":"Walk around the exhibition and meet great people."}],children:[]},{type:"Spacer",title:"Afternoon",subtitle:"",children:[]},{type:"Detail",title:"Fifth Session",subtitle:"Track A | 13:00-14:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Sixth Session",subtitle:"Track B | 13:00-14:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Seventh Session",subtitle:"Track A | 15:00-16:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Eigth Session",subtitle:"Track B | 15:00-16:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},]},{type:"Navigation",title:"Day 03",subtitle:_17,children:[{type:"Spacer",title:"Morning",subtitle:"",children:[]},{type:"Detail",title:"First Session",subtitle:"Track A | 9:00-10:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Second Session",subtitle:"Track B | 9:00-10:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Third Session",subtitle:"Track A | 10:45-11:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Fourth Session",subtitle:"Track B | 10:45-11:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Lunch",subtitle:"11:30-13:00",attributes:[{"key":"Location","value":"Get great food and drinks down in the main area."},{"key":"Exhibition","value":"Walk around the exhibition and meet great people."}],children:[]},{type:"Spacer",title:"Afternoon",subtitle:"",children:[]},{type:"Detail",title:"Fifth Session",subtitle:"Track A | 13:00-14:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Sixth Session",subtitle:"Track B | 13:00-14:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Seventh Session",subtitle:"Track A | 15:00-16:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Eigth Session",subtitle:"Track B | 15:00-16:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},]},{type:"Spacer",title:"",subtitle:"",children:[]},{type:"Navigation",title:"Infos",subtitle:"General information",children:[]}]}};
return JSON.stringify(_19);
}
})]);
p;11;OpenPanel.jt;2416;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.jt;2350;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("AppKit/CPPanel.j",NO);
var _1=objj_allocateClassPair(CPPanel,"OpenPanel"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("field")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("initWithName:andDelegate:"),function(_8,_9,_a,_b){
with(_8){
_8=objj_msgSend(_8,"initWithContentRect:styleMask:",CGRectMake(200,150,330,140),CPHUDBackgroundWindowMask);
if(_8){
_8.delegate=_b;
objj_msgSend(_8,"setTitle:","Open Agenda");
objj_msgSend(_8,"setFloatingPanel:",YES);
var _c=objj_msgSend(_8,"contentView"),_d=objj_msgSend(_c,"bounds");
var _e=objj_msgSend(CPTextField,"labelWithTitle:","Enter the name of your agenda.");
objj_msgSend(_e,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(_e,"sizeToFit");
objj_msgSend(_e,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_e,"setFrameOrigin:",CGPointMake(45,5));
objj_msgSend(_c,"addSubview:",_e);
field=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:",_a,"",200);
objj_msgSend(field,"setFrameOrigin:",CGPointMake(70,35));
objj_msgSend(_c,"addSubview:",field);
var _f=objj_msgSend(CPButton,"buttonWithTitle:theme:","Open",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_f,"setFrame:",CGRectMake(250,90,70,20));
objj_msgSend(_c,"addSubview:",_f);
objj_msgSend(_f,"setTag:","open");
objj_msgSend(_f,"setTarget:",_8);
objj_msgSend(_f,"setAction:",sel_getUid("buttonAction:"));
var _10=objj_msgSend(CPButton,"buttonWithTitle:theme:","Cancel",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_10,"setFrame:",CGRectMake(170,90,70,20));
objj_msgSend(_c,"addSubview:",_10);
objj_msgSend(_10,"setTag:","opencancel");
objj_msgSend(_10,"setTarget:",_8);
objj_msgSend(_10,"setAction:",sel_getUid("buttonAction:"));
}
return _8;
}
}),new objj_method(sel_getUid("buttonAction:"),function(_11,_12,_13){
with(_11){
if(objj_msgSend(delegate,"respondsToSelector:",sel_getUid("panelDidClose:data:"))){
objj_msgSend(delegate,"panelDidClose:data:",objj_msgSend(_13,"tag"),objj_msgSend(field,"objectValue"));
}
objj_msgSend(_11,"close");
}
})]);
p;6;Page.jt;4165;@STATIC;1.0;I;21;Foundation/CPObject.jt;4120;
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
}),new objj_method(sel_getUid("isRootPage"),function(_32,_33){
with(_32){
return _32.ancestor==null;
}
}),new objj_method(sel_getUid("removeChild:"),function(_34,_35,_36){
with(_34){
objj_msgSend(children,"removeObjectAtIndex:",_36);
}
}),new objj_method(sel_getUid("toJSON"),function(_37,_38){
with(_37){
var _39="";
for(var i=0;i<children.length;i++){
_39+=objj_msgSend(children[i],"toJSON");
_39+=",";
}
if(_39.length>0){
_39=_39.substring(0,_39.length-1);
}
var _3a="";
for(var i=0;i<attributes.length;i++){
_3a+="{\"key\":\""+attributes[i].key+"\"";
_3a+=",\"value\":\""+attributes[i].value+"\"}";
_3a+=",";
}
if(_3a.length>0){
_3a=_3a.substring(0,_3a.length-1);
}
var _3b="{\"title\":\""+title;
if(subtitle){
_3b+="\",\"subtitle\":\""+subtitle;
}
_3b+="\",\"type\":\""+type+"\",\"children\":["+_39+"],\"attributes\":["+_3a+"]}";
return _3b;
}
}),new objj_method(sel_getUid("description"),function(_3c,_3d){
with(_3c){
return title;
}
}),new objj_method(sel_getUid("isNavigationType"),function(_3e,_3f){
with(_3e){
return type==="Navigation";
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("initFromJSONObject:andNavigationId:"),function(_40,_41,_42,_43){
with(_40){
var _44=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andNavigationId:",_42.title,_42.subtitle,_42.type,_43);
for(var i=0;i<_42.children.length;i++){
var _45=_43+"c"+i;
var _46=objj_msgSend(Page,"initFromJSONObject:andNavigationId:",_42.children[i],_45);
objj_msgSend(_44,"addChild:atIndex:",_46,-1);
}
if(_42.attributes){
for(var i=0;i<_42.attributes.length;i++){
var _47=_42.attributes[i];
objj_msgSend(objj_msgSend(_44,"attributes"),"insertObject:atIndex:",_47,i);
}
}
return _44;
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
p;20;PageViewController.jt;10922;@STATIC;1.0;I;21;Foundation/CPObject.ji;18;ButtonColumnView.ji;21;CPPropertyAnimation.ji;21;ImageTextColumnView.jt;10801;
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
objj_msgSend(titleField,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(titleField,"setValue:forThemeAttribute:",CPCenterTextAlignment,"alignment");
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
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:","EditingDoneNotification",nil);
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
return YES;
}
}),new objj_method(sel_getUid("addItemToList:"),function(_3b,_3c,_3d){
with(_3b){
var _3e=objj_msgSend(table,"selectedRow");
if(_3e<0){
_3e=page.children.length;
}
if(objj_msgSend(page,"isNavigationType")){
var _3f=objj_msgSend(objj_msgSend(itemtypeButton,"selectedItem"),"title");
var _40;
var _41=page.navigationId+"c"+_3e;
if(_3f=="Navigationpage"){
_40=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andNavigationId:","The title of a subpage","The optional subtitle of a subpage","Navigation",_41);
}else{
if(_3f=="Detailpage"){
_40=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andNavigationId:","The title of a subpage","The optional subtitle of a subpage","Detail",_41);
}else{
_40=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andNavigationId:","A group title","","Spacer",_41);
}
}
objj_msgSend(page,"addChild:atIndex:",_40,_3e);
}else{
var _42={key:"A key",value:"A value"};
objj_msgSend(objj_msgSend(page,"attributes"),"insertObject:atIndex:",_42,_3e);
}
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:","AddItemToListNotification",nil);
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
if(console){
console.log("animationDidEnd");
}
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
if(!page.title){
_50="Untitled";
}
if(!objj_msgSend(page,"isRootPage")){
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
objj_msgSend(itemtypeButton,"addItemsWithTitles:",["Text"]);
}
}
})]);
p;12;SharePanel.jt;2876;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.jt;2810;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("AppKit/CPPanel.j",NO);
var _1=objj_allocateClassPair(CPPanel,"SharePanel"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("appname")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("init:andAppname:"),function(_8,_9,_a,_b){
with(_8){
_8=objj_msgSend(_8,"initWithContentRect:styleMask:",CGRectMake(200,110,310,130),CPHUDBackgroundWindowMask);
_8.appname=_b;
if(_8){
_8.delegate=_a;
objj_msgSend(_8,"setTitle:","Share");
objj_msgSend(_8,"setFloatingPanel:",YES);
var _c=objj_msgSend(_8,"contentView"),_d=objj_msgSend(_c,"bounds");
var _e=objj_msgSend(CPTextField,"labelWithTitle:","Share your agenda:");
objj_msgSend(_e,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(_e,"sizeToFit");
objj_msgSend(_e,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_e,"setFrameOrigin:",CGPointMake(35,17));
objj_msgSend(_c,"addSubview:",_e);
var _f=objj_msgSend(CPButton,"buttonWithTitle:theme:","via Twitter",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_f,"setFrame:",CGRectMake(170,5,110,20));
objj_msgSend(_c,"addSubview:",_f);
objj_msgSend(_f,"setTag:","twitter");
objj_msgSend(_f,"setTarget:",_8);
objj_msgSend(_f,"setAction:",sel_getUid("buttonAction:"));
var _10=objj_msgSend(CPButton,"buttonWithTitle:theme:","via Email",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_10,"setFrame:",CGRectMake(170,35,110,20));
objj_msgSend(_c,"addSubview:",_10);
objj_msgSend(_10,"setTag:","email");
objj_msgSend(_10,"setTarget:",_8);
objj_msgSend(_10,"setAction:",sel_getUid("buttonAction:"));
var _11=objj_msgSend(CPButton,"buttonWithTitle:theme:","Cancel",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_11,"setFrame:",CGRectMake(170,80,110,20));
objj_msgSend(_c,"addSubview:",_11);
objj_msgSend(_11,"setTag:","cancel");
objj_msgSend(_11,"setTarget:",_8);
objj_msgSend(_11,"setAction:",sel_getUid("buttonAction:"));
}
return _8;
}
}),new objj_method(sel_getUid("buttonAction:"),function(_12,_13,_14){
with(_12){
switch(objj_msgSend(_14,"tag")){
case "email":
window.open("mailto:matthias@luebken.com?body=I've created an agenda for "+appname+". Open it on your smartphone http://touchium.com/a/"+appname,"emailwindow");
window.close("emailwindow");
break;
case "twitter":
window.open("http://twitter.com/?status=I've created an agenda for "+appname+". Open it on your smartphone http://touchium.com/a/"+appname,"twitterwindow");
}
objj_msgSend(delegate,"panelDidClose:data:",objj_msgSend(_14,"tag"),nil);
objj_msgSend(_12,"close");
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
p;23;DatePicker/DatePicker.jt;39991;@STATIC;1.0;I;18;AppKit/CPControl.ji;9;Stepper.jt;39935;
objj_executeFile("AppKit/CPControl.j",NO);
objj_executeFile("Stepper.j",YES);
CPLogRegister(CPLogConsole);
var _1=objj_allocateClassPair(CPControl,"DatePicker"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_theView"),new objj_ivar("_theStepper"),new objj_ivar("segments"),new objj_ivar("superController"),new objj_ivar("_date"),new objj_ivar("_minDate"),new objj_ivar("_maxDate"),new objj_ivar("bezel"),new objj_ivar("bezelFocused"),new objj_ivar("dateSegmentFocused"),new objj_ivar("focused"),new objj_ivar("inputManager"),new objj_ivar("currentFocusedSegment"),new objj_ivar("lastFocusedSegment"),new objj_ivar("_delegate"),new objj_ivar("activeDateSegment"),new objj_ivar("prevActiveDateSegment"),new objj_ivar("superController"),new objj_ivar("_dontsetfirsttome")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("_theView"),function(_3,_4){
with(_3){
return _theView;
}
}),new objj_method(sel_getUid("_setTheView:"),function(_5,_6,_7){
with(_5){
_theView=_7;
}
}),new objj_method(sel_getUid("_theStepper"),function(_8,_9){
with(_8){
return _theStepper;
}
}),new objj_method(sel_getUid("_setTheStepper:"),function(_a,_b,_c){
with(_a){
_theStepper=_c;
}
}),new objj_method(sel_getUid("segments"),function(_d,_e){
with(_d){
return segments;
}
}),new objj_method(sel_getUid("setSegments:"),function(_f,_10,_11){
with(_f){
segments=_11;
}
}),new objj_method(sel_getUid("superController"),function(_12,_13){
with(_12){
return superController;
}
}),new objj_method(sel_getUid("setSuperController:"),function(_14,_15,_16){
with(_14){
superController=_16;
}
}),new objj_method(sel_getUid("focused"),function(_17,_18){
with(_17){
return focused;
}
}),new objj_method(sel_getUid("setFocused:"),function(_19,_1a,_1b){
with(_19){
focused=_1b;
}
}),new objj_method(sel_getUid("inputManager"),function(_1c,_1d){
with(_1c){
return inputManager;
}
}),new objj_method(sel_getUid("setInputManager:"),function(_1e,_1f,_20){
with(_1e){
inputManager=_20;
}
}),new objj_method(sel_getUid("currentFocusedSegment"),function(_21,_22){
with(_21){
return currentFocusedSegment;
}
}),new objj_method(sel_getUid("setCurrentFocusedSegment:"),function(_23,_24,_25){
with(_23){
currentFocusedSegment=_25;
}
}),new objj_method(sel_getUid("lastFocusedSegment"),function(_26,_27){
with(_26){
return lastFocusedSegment;
}
}),new objj_method(sel_getUid("setLastFocusedSegment:"),function(_28,_29,_2a){
with(_28){
lastFocusedSegment=_2a;
}
}),new objj_method(sel_getUid("activeDateSegment"),function(_2b,_2c){
with(_2b){
return activeDateSegment;
}
}),new objj_method(sel_getUid("setActiveDateSegment:"),function(_2d,_2e,_2f){
with(_2d){
activeDateSegment=_2f;
}
}),new objj_method(sel_getUid("prevActiveDateSegment"),function(_30,_31){
with(_30){
return prevActiveDateSegment;
}
}),new objj_method(sel_getUid("setPrevActiveDateSegment:"),function(_32,_33,_34){
with(_32){
prevActiveDateSegment=_34;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_35,_36,_37){
with(_35){
_35=objj_msgSendSuper({receiver:_35,super_class:objj_getClass("DatePicker").super_class},"initWithFrame:",_37);
if(_35){
_theView=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",CGRectMake(4,3,CGRectGetWidth(_37)-20,23));
bezel=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPNinePartImage,"alloc"),"initWithImageSlices:",[objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-0.png",CGSizeMake(2,3)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-1.png",CGSizeMake(1,3)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-2.png",CGSizeMake(2,3)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-3.png",CGSizeMake(2,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-4.png",CGSizeMake(1,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-5.png",CGSizeMake(2,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-6.png",CGSizeMake(2,2)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-7.png",CGSizeMake(1,2)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-8.png",CGSizeMake(2,2))]));
bezelFocused=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPNinePartImage,"alloc"),"initWithImageSlices:",[objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-focused-0.png",CGSizeMake(6,7)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-focused-1.png",CGSizeMake(1,7)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-focused-2.png",CGSizeMake(6,7)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-focused-3.png",CGSizeMake(6,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-focused-4.png",CGSizeMake(1,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-focused-5.png",CGSizeMake(6,1)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-focused-6.png",CGSizeMake(6,5)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-focused-7.png",CGSizeMake(1,5)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Frameworks/AppKit/Resources/Aristo.blend/Resources/textfield-bezel-square-focused-8.png",CGSizeMake(6,5))]));
objj_msgSend(_theView,"setBackgroundColor:",bezel);
inputManager=_35;
objj_msgSend(inputManager,"setSuperController:",_35);
_theStepper=objj_msgSend(objj_msgSend(Stepper,"alloc"),"initWithFrame:",CGRectMake(_37.size.width-13,3,13,23));
objj_msgSend(_theStepper,"setTarget:",_35);
objj_msgSend(_theStepper,"setAction:",sel_getUid("stepperAction:"));
objj_msgSend(_35,"addSubview:",_theView);
objj_msgSend(_35,"addSubview:",_theStepper);
_date=objj_msgSend(CPDate,"dateWithTimeIntervalSinceNow:",0);
_maxDate=objj_msgSend(CPDate,"distantFuture");
_minDate=objj_msgSend(CPDate,"distantPast");
segments=objj_msgSend(objj_msgSend(CPArray,"alloc"),"init");
focused=NO;
objj_msgSend(_theStepper,"setEnabled:",NO);
objj_msgSend(_theStepper,"setMaxValue:",9999);
objj_msgSend(_theStepper,"setMinValue:",-1);
}
return _35;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_38,_39,_3a){
with(_38){
var _3b=objj_msgSend(CPNotificationCenter,"defaultCenter");
if(_delegate){
objj_msgSend(_3b,"removeObserver:name:object:",_delegate,"datePickerDidChangeNotification",_38);
}
_delegate=_3a;
if(objj_msgSend(_delegate,"respondsToSelector:",sel_getUid("datePickerDidChange:"))){
objj_msgSend(_3b,"addObserver:selector:name:object:",_delegate,sel_getUid("datePickerDidChange:"),"datePickerDidChangeNotification",_38);
}
if(objj_msgSend(_delegate,"respondsToSelector:",sel_getUid("datePickerDidLoseFocus:"))){
objj_msgSend(_3b,"addObserver:selector:name:object:",_delegate,sel_getUid("datePickerDidLoseFocus:"),"datePickerDidLoseFocusNotification",_38);
}
}
}),new objj_method(sel_getUid("addDateSegmentOfType:withInitialValue:withSeperatorAtEnd:"),function(_3c,_3d,_3e,_3f,_40){
with(_3c){
var _41=objj_msgSend(_3c,"makeFrameForType:",_3e);
var _42=objj_msgSend(objj_msgSend(DateSegment,"alloc"),"initWithFrame:",CGRectMake(6,7,20,18));
objj_msgSend(dateSegmentes,"addObject:",_42);
objj_msgSend(_3c,"addSubview:",_42);
}
}),new objj_method(sel_getUid("displayPreset:"),function(_43,_44,_45){
with(_43){
if(_45==1){
var _46=objj_msgSend(objj_msgSend(DateSegment,"alloc"),"initWithFrame:",CGRectMake(6,7,20,18));
objj_msgSend(_46,"setStringValue:","00");
objj_msgSend(_46,"sizeToFit");
objj_msgSend(_46,"setDelegate:",_43);
objj_msgSend(_46,"setInputManager:",_43);
objj_msgSend(_46,"setSuperController:",_43);
objj_msgSend(_46,"setDateType:",1);
if(CGRectGetHeight(objj_msgSend(_43,"frame"))-CGRectGetHeight(objj_msgSend(_46,"frame"))<14){
objj_msgSend(_43,"setFrame:",CGRectMake(CGRectGetMinX(objj_msgSend(_43,"frame")),CGRectGetMinY(objj_msgSend(_43,"frame")),CGRectGetWidth(objj_msgSend(_43,"frame")),CGRectGetHeight(objj_msgSend(_46,"frame"))+14));
objj_msgSend(_theView,"setFrame:",CGRectMake(CGRectGetMinX(objj_msgSend(_theView,"frame")),CGRectGetMinY(objj_msgSend(_theView,"frame")),CGRectGetWidth(objj_msgSend(_theView,"frame")),CGRectGetHeight(objj_msgSend(_46,"frame"))+6));
}
var _47=objj_msgSend(objj_msgSend(DateSegment,"alloc"),"initWithFrame:",CGRectMake(28,7,20,18));
objj_msgSend(_47,"setStringValue:","00");
objj_msgSend(_47,"sizeToFit");
objj_msgSend(_47,"setDelegate:",_43);
objj_msgSend(_47,"setInputManager:",_43);
objj_msgSend(_47,"setSuperController:",_43);
objj_msgSend(_47,"setDateType:",2);
var _48=objj_msgSend(objj_msgSend(DateSegment,"alloc"),"initWithFrame:",CGRectMake(50,7,35,18));
objj_msgSend(_48,"setStringValue:","0000");
objj_msgSend(_48,"sizeToFit");
objj_msgSend(_48,"setDelegate:",_43);
objj_msgSend(_48,"setInputManager:",_43);
objj_msgSend(_48,"setSuperController:",_43);
objj_msgSend(_48,"setDateType:",3);
objj_msgSend(_43,"addSubview:",_46);
objj_msgSend(_43,"addSubview:",_47);
objj_msgSend(_43,"addSubview:",_48);
objj_msgSend(segments,"addObject:",_46);
objj_msgSend(segments,"addObject:",_47);
objj_msgSend(segments,"addObject:",_48);
var _49=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(23,7,15,18));
objj_msgSend(_49,"setStringValue:","/");
objj_msgSend(_49,"sizeToFit");
var _4a=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(44,7,15,18));
objj_msgSend(_4a,"setStringValue:","/");
objj_msgSend(_4a,"sizeToFit");
objj_msgSend(_43,"addSubview:",_49);
objj_msgSend(_43,"addSubview:",_4a);
}else{
if(_45==2){
var _4b=objj_msgSend(objj_msgSend(DateSegment,"alloc"),"initWithFrame:",CGRectMake(6,7,20,18));
objj_msgSend(_4b,"setStringValue:","00");
objj_msgSend(_4b,"sizeToFit");
objj_msgSend(_4b,"setDelegate:",_43);
objj_msgSend(_4b,"setInputManager:",_43);
objj_msgSend(_4b,"setSuperController:",_43);
objj_msgSend(_4b,"setDateType:",9);
if(CGRectGetHeight(objj_msgSend(_43,"frame"))-CGRectGetHeight(objj_msgSend(_4b,"frame"))<14){
objj_msgSend(_43,"setFrame:",CGRectMake(CGRectGetMinX(objj_msgSend(_43,"frame")),CGRectGetMinY(objj_msgSend(_43,"frame")),CGRectGetWidth(objj_msgSend(_43,"frame")),CGRectGetHeight(objj_msgSend(_4b,"frame"))+14));
objj_msgSend(_theView,"setFrame:",CGRectMake(CGRectGetMinX(objj_msgSend(_theView,"frame")),CGRectGetMinY(objj_msgSend(_theView,"frame")),CGRectGetWidth(objj_msgSend(_theView,"frame")),CGRectGetHeight(objj_msgSend(_4b,"frame"))+6));
}
var _4c=objj_msgSend(objj_msgSend(DateSegment,"alloc"),"initWithFrame:",CGRectMake(28,7,20,18));
objj_msgSend(_4c,"setStringValue:","00");
objj_msgSend(_4c,"sizeToFit");
objj_msgSend(_4c,"setDelegate:",_43);
objj_msgSend(_4c,"setInputManager:",_43);
objj_msgSend(_4c,"setSuperController:",_43);
objj_msgSend(_4c,"setDateType:",8);
var _4d=objj_msgSend(objj_msgSend(DateSegment,"alloc"),"initWithFrame:",CGRectMake(45,7,20,18));
objj_msgSend(_4d,"setStringValue:","AM");
objj_msgSend(_4d,"sizeToFit");
objj_msgSend(_4d,"setDelegate:",_43);
objj_msgSend(_4d,"setInputManager:",_43);
objj_msgSend(_4d,"setSuperController:",_43);
objj_msgSend(_4d,"setDateType:",10);
objj_msgSend(_43,"addSubview:",_4b);
objj_msgSend(_43,"addSubview:",_4c);
objj_msgSend(_43,"addSubview:",_4d);
objj_msgSend(segments,"addObject:",_4b);
objj_msgSend(segments,"addObject:",_4c);
objj_msgSend(segments,"addObject:",_4d);
var _49=objj_msgSend(objj_msgSend(CPTextField,"alloc"),"initWithFrame:",CGRectMake(23,7,15,18));
objj_msgSend(_49,"setStringValue:",":");
objj_msgSend(_43,"addSubview:",_49);
}
}
objj_msgSend(_43,"updatePickerDisplay");
}
}),new objj_method(sel_getUid("minDate"),function(_4e,_4f){
with(_4e){
return _minDate;
}
}),new objj_method(sel_getUid("setMinDate:"),function(_50,_51,_52){
with(_50){
_minDate=objj_msgSend(_52,"copy");
if(objj_msgSend(_50,"_mutableDate")<objj_msgSend(_50,"minDate")){
objj_msgSend(_50,"setDate:",objj_msgSend(_50,"minDate"));
}
}
}),new objj_method(sel_getUid("maxDate"),function(_53,_54){
with(_53){
return _maxDate;
}
}),new objj_method(sel_getUid("setMaxDate:"),function(_55,_56,_57){
with(_55){
_maxDate=objj_msgSend(_57,"copy");
if(objj_msgSend(_55,"_mutableDate")<objj_msgSend(_55,"maxDate")){
objj_msgSend(_55,"setDate:",objj_msgSend(_55,"maxDate"));
}
}
}),new objj_method(sel_getUid("date"),function(_58,_59){
with(_58){
return objj_msgSend(_date,"copy");
}
}),new objj_method(sel_getUid("_mutableDate"),function(_5a,_5b){
with(_5a){
return _date;
}
}),new objj_method(sel_getUid("setDate:"),function(_5c,_5d,_5e){
with(_5c){
_date=objj_msgSend(_5e,"copy");
objj_msgSend(_5c,"updatePickerDisplay");
}
}),new objj_method(sel_getUid("updatePickerDisplay"),function(_5f,_60){
with(_5f){
for(var i=0;i<objj_msgSend(segments,"count");i++){
var _61=objj_msgSend(segments,"objectAtIndex:",i);
if(objj_msgSend(_61,"dateType")==1){
var _62=objj_msgSend(_5f,"_mutableDate").getMonth()+1;
objj_msgSend(_61,"setStringValue:",objj_msgSend(_61,"singleNumber:",_62));
}else{
if(objj_msgSend(_61,"dateType")==2){
var _62=objj_msgSend(_5f,"_mutableDate").getDate();
objj_msgSend(_61,"setStringValue:",objj_msgSend(_61,"doubleNumber:",_62));
}else{
if(objj_msgSend(_61,"dateType")==3){
var _62=objj_msgSend(_5f,"_mutableDate").getFullYear();
objj_msgSend(_61,"setStringValue:",objj_msgSend(_61,"quadNumber:",_62));
}else{
if(objj_msgSend(_61,"dateType")==8){
var _62=objj_msgSend(_5f,"_mutableDate").getMinutes();
objj_msgSend(_61,"setStringValue:",objj_msgSend(_61,"doubleNumber:",_62));
}else{
if(objj_msgSend(_61,"dateType")==9){
var _62=objj_msgSend(_5f,"_mutableDate").getHours();
if(_62>12){
_62=_62-12;
}else{
if(objj_msgSend(_5f,"_mutableDate").getHours()==0){
_62=12;
}
}
objj_msgSend(_61,"setStringValue:",objj_msgSend(_61,"singleNumber:",_62));
}else{
if(objj_msgSend(_61,"dateType")==10){
var _62=objj_msgSend(_5f,"_mutableDate").getHours();
if(_62>11){
_62="PM";
}else{
_62="AM";
}
objj_msgSend(_61,"setStringValue:",objj_msgSend(_61,"singleNumber:",_62));
}
}
}
}
}
}
}
}
}),new objj_method(sel_getUid("becomeFirstResponder"),function(_63,_64){
with(_63){
if(!currentFocusedSegment){
objj_msgSend(_63,"setActiveDateSegment:",objj_msgSend(segments,"objectAtIndex:",0));
}
return YES;
}
}),new objj_method(sel_getUid("acceptsFirstResponder"),function(_65,_66){
with(_65){
return YES;
}
}),new objj_method(sel_getUid("resignFirstResponder"),function(_67,_68){
with(_67){
objj_msgSend(_67,"setPrevActiveDateSegment:",objj_msgSend(_67,"activeDateSegment"));
objj_msgSend(_67,"setActiveDateSegment:",nil);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:userInfo:","datePickerDidLoseFocusNotification",superController,nil);
return YES;
}
}),new objj_method(sel_getUid("mouseDown:"),function(_69,_6a,_6b){
with(_69){
objj_msgSendSuper({receiver:_69,super_class:objj_getClass("DatePicker").super_class},"mouseDown:",_6b);
if(!currentFocusedSegment){
objj_msgSend(_69,"setActiveDateSegment:",objj_msgSend(segments,"objectAtIndex:",0));
objj_msgSend(objj_msgSend(_69,"window"),"makeFirstResponder:",_69);
}
}
}),new objj_method(sel_getUid("setFocused:"),function(_6c,_6d,val){
with(_6c){
if(focused===val){
return;
}
focused=val;
if(focused){
objj_msgSend(_theView,"setFrame:",CGRectMake(objj_msgSend(_theView,"frame").origin.x-4,objj_msgSend(_theView,"frame").origin.y-3,objj_msgSend(_theView,"frame").size.width+8,objj_msgSend(_theView,"frame").size.height+6));
objj_msgSend(_theView,"setBackgroundColor:",bezelFocused);
}else{
objj_msgSend(_theView,"setBackgroundColor:",bezel);
objj_msgSend(_theView,"setFrame:",CGRectMake(objj_msgSend(_theView,"frame").origin.x+4,objj_msgSend(_theView,"frame").origin.y+3,objj_msgSend(_theView,"frame").size.width-8,objj_msgSend(_theView,"frame").size.height-6));
}
}
}),new objj_method(sel_getUid("maxDays"),function(_6e,_6f){
with(_6e){
if(objj_msgSend(_6e,"_mutableDate").getFullYear()>=objj_msgSend(_6e,"maxYear")&&objj_msgSend(_6e,"_mutableDate").getMonth()>=objj_msgSend(_6e,"maxMonth")){
return objj_msgSend(_6e,"maxDate").getDate();
}
var _70=objj_msgSend(_6e,"_mutableDate").getMonth();
var _71=nil;
if(_70==0||_70==2||_70==4||_70==6||_70==7||_70==9||_70==11){
_71=31;
}else{
if(_70==1){
_71=28;
if(objj_msgSend(_6e,"isLeapYear")){
_71++;
}
}else{
if(_70==3||_70==5||_70==8||_70==10){
_71=30;
}else{
_71=0;
}
}
}
return _71;
}
}),new objj_method(sel_getUid("maxMonth"),function(_72,_73){
with(_72){
if(objj_msgSend(_72,"_mutableDate").getFullYear()>=objj_msgSend(_72,"maxYear")){
return objj_msgSend(_72,"maxDate").getMonth()+1;
}else{
return 12;
}
}
}),new objj_method(sel_getUid("maxYear"),function(_74,_75){
with(_74){
if(objj_msgSend(_74,"maxDate")){
return objj_msgSend(_74,"maxDate").getFullYear();
}else{
return 9999;
}
}
}),new objj_method(sel_getUid("minDays"),function(_76,_77){
with(_76){
if(objj_msgSend(_76,"_mutableDate").getFullYear()<=objj_msgSend(_76,"minYear")&&objj_msgSend(_76,"_mutableDate").getMonth()<=objj_msgSend(_76,"minMonth")){
return objj_msgSend(_76,"minDate").getDate();
}
var _78=1;
return _78;
}
}),new objj_method(sel_getUid("minMonth"),function(_79,_7a){
with(_79){
if(objj_msgSend(_79,"_mutableDate").getFullYear()<=objj_msgSend(_79,"minYear")){
return objj_msgSend(_79,"minDate").getMonth()+1;
}else{
return 1;
}
}
}),new objj_method(sel_getUid("minYear"),function(_7b,_7c){
with(_7b){
var _7d=objj_msgSend(_7b,"minDate").getFullYear();
if(objj_msgSend(_7b,"minDate")){
return objj_msgSend(_7b,"minDate").getFullYear();
}else{
return 1;
}
}
}),new objj_method(sel_getUid("maxHours"),function(_7e,_7f){
with(_7e){
return 12;
}
}),new objj_method(sel_getUid("maxMins"),function(_80,_81){
with(_80){
return 59;
}
}),new objj_method(sel_getUid("maxAMPM"),function(_82,_83){
with(_82){
return 1;
}
}),new objj_method(sel_getUid("minHours"),function(_84,_85){
with(_84){
return 1;
}
}),new objj_method(sel_getUid("minMins"),function(_86,_87){
with(_86){
return 0;
}
}),new objj_method(sel_getUid("minAMPM"),function(_88,_89){
with(_88){
return 0;
}
}),new objj_method(sel_getUid("isLeapYear"),function(_8a,_8b){
with(_8a){
var yr=objj_msgSend(_8a,"_mutableDate").getFullYear();
return !(yr%4)&&(yr%100)||!(yr%400)?true:false;
}
}),new objj_method(sel_getUid("setActiveDateSegment:"),function(_8c,_8d,_8e){
with(_8c){
if(activeDateSegment===_8e){
return;
}
if(objj_msgSend(_8c,"activeDateSegment")){
objj_msgSend(_8c,"setLastFocusedSegment:",activeDateSegment);
objj_msgSend(activeDateSegment,"makeInactive");
}
activeDateSegment=_8e;
if(activeDateSegment){
objj_msgSend(_8c,"setFocused:",YES);
objj_msgSend(activeDateSegment,"makeActive");
objj_msgSend(_8c,"setCurrentFocusedSegment:",activeDateSegment);
objj_msgSend(objj_msgSend(_8c,"window"),"makeFirstResponder:",_8c);
}else{
objj_msgSend(_8c,"setFocused:",NO);
objj_msgSend(_8c,"setCurrentFocusedSegment:",activeDateSegment);
}
}
}),new objj_method(sel_getUid("keyDown:"),function(_8f,_90,_91){
with(_8f){
objj_msgSend(_8f,"interpretKeyEvents:",_91);
}
}),new objj_method(sel_getUid("interpretKeyEvents:"),function(_92,_93,_94){
with(_92){
var key=objj_msgSend(_94,"keyCode");
if(key==CPTabKeyCode){
if(objj_msgSend(_92,"activeDateSegment")==objj_msgSend(segments,"objectAtIndex:",objj_msgSend(objj_msgSend(superController,"segments"),"count")-1)){
objj_msgSend(objj_msgSend(_92,"window"),"selectNextKeyView:",_92);
return;
}else{
var i=objj_msgSend(segments,"indexOfObject:",objj_msgSend(_92,"activeDateSegment"));
i++;
i=objj_msgSend(segments,"objectAtIndex:",i);
}
objj_msgSend(_92,"setActiveDateSegment:",i);
}else{
if(key==CPRightArrowKeyCode||key==189||key==188||key==190||key==191||key==186){
if(objj_msgSend(_92,"activeDateSegment")==objj_msgSend(segments,"objectAtIndex:",objj_msgSend(segments,"count")-1)){
i=objj_msgSend(segments,"objectAtIndex:",0);
}else{
var i=objj_msgSend(segments,"indexOfObject:",objj_msgSend(_92,"activeDateSegment"));
i++;
i=objj_msgSend(segments,"objectAtIndex:",i);
}
objj_msgSend(_92,"setActiveDateSegment:",i);
}else{
if(key==CPLeftArrowKeyCode){
if(objj_msgSend(_92,"activeDateSegment")==objj_msgSend(segments,"objectAtIndex:",0)){
i=objj_msgSend(segments,"objectAtIndex:",objj_msgSend(segments,"count")-1);
}else{
var i=objj_msgSend(segments,"indexOfObject:",objj_msgSend(_92,"activeDateSegment"));
i--;
i=objj_msgSend(segments,"objectAtIndex:",i);
}
objj_msgSend(_92,"setActiveDateSegment:",i);
}else{
if(key==CPDeleteKeyCode&&objj_msgSend(activeDateSegment,"dateType")!==10){
objj_msgSend(activeDateSegment,"removeLastChar");
}else{
if(key==CPUpArrowKeyCode){
objj_msgSend(activeDateSegment,"increment");
}else{
if(key==CPDownArrowKeyCode){
objj_msgSend(activeDateSegment,"decrement");
}else{
if(key==48||key==96){
objj_msgSend(activeDateSegment,"sendNewInput:","0");
}else{
if(key==49||key==97){
objj_msgSend(activeDateSegment,"sendNewInput:","1");
}else{
if(key==50||key==98){
objj_msgSend(activeDateSegment,"sendNewInput:","2");
}else{
if(key==51||key==99){
objj_msgSend(activeDateSegment,"sendNewInput:","3");
}else{
if(key==52||key==100){
objj_msgSend(activeDateSegment,"sendNewInput:","4");
}else{
if(key==53||key==101){
objj_msgSend(activeDateSegment,"sendNewInput:","5");
}else{
if(key==54||key==102){
objj_msgSend(activeDateSegment,"sendNewInput:","6");
}else{
if(key==55||key==103){
objj_msgSend(activeDateSegment,"sendNewInput:","7");
}else{
if(key==56||key==104){
objj_msgSend(activeDateSegment,"sendNewInput:","8");
}else{
if(key==57||key==105){
objj_msgSend(activeDateSegment,"sendNewInput:","9");
}else{
if(key==65&&objj_msgSend(activeDateSegment,"dateType")==10){
objj_msgSend(activeDateSegment,"sendNewInput:","A");
}else{
if(key==80&&objj_msgSend(activeDateSegment,"dateType")==10){
objj_msgSend(activeDateSegment,"sendNewInput:","P");
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}),new objj_method(sel_getUid("stepperAction:"),function(_95,_96,_97){
with(_95){
if(!activeDateSegment){
objj_msgSend(_95,"setActiveDateSegment:",(prevActiveDateSegment)?prevActiveDateSegment:objj_msgSend(segments,"objectAtIndex:",0));
}
var _98=objj_msgSend(_theStepper,"intValue");
if(objj_msgSend(activeDateSegment,"dateType")==1){
var _99=objj_msgSend(_95,"maxMonth");
var _9a=objj_msgSend(_95,"minMonth");
if(_98>_99){
_98=_9a;
}else{
if(_98<_9a){
_98=_99;
}
}
objj_msgSend(_95,"_mutableDate").setMonth(_98-1);
}else{
if(objj_msgSend(activeDateSegment,"dateType")==2){
var _99=objj_msgSend(_95,"maxDays");
var _9a=objj_msgSend(_95,"minDays");
if(_98>_99){
_98=_9a;
}else{
if(_98<_9a){
_98=_99;
}
}
objj_msgSend(superController,"_mutableDate").setDate(_98);
_98=objj_msgSend(activeDateSegment,"doubleNumber:",_98);
}else{
if(objj_msgSend(activeDateSegment,"dateType")==3){
var _99=objj_msgSend(_95,"maxYear");
var _9a=objj_msgSend(_95,"minYear");
if(_98>_99){
_98=_9a;
}else{
if(_98<_9a){
_98=_99;
}
}
objj_msgSend(superController,"_mutableDate").setFullYear(_98);
}else{
if(objj_msgSend(activeDateSegment,"dateType")==8){
var _99=objj_msgSend(_95,"maxMins");
var _9a=objj_msgSend(_95,"minMins");
if(_98>_99){
_98=_9a;
}else{
if(_98<_9a){
_98=_99;
}
}
objj_msgSend(superController,"_mutableDate").setMinutes(_98);
_98=objj_msgSend(activeDateSegment,"doubleNumber:",_98);
}else{
if(objj_msgSend(activeDateSegment,"dateType")==9){
var _99=objj_msgSend(_95,"maxHours");
var _9a=objj_msgSend(_95,"minHours");
if(_98>_99){
_98=_9a;
}else{
if(_98<_9a){
_98=_99;
}
}
var _9b=_98;
var _9c=objj_msgSend(segments,"objectAtIndex:",objj_msgSend(segments,"count")-1);
if(objj_msgSend(_9c,"stringValue")==="PM"&&_98!==12){
_98=_98+12;
}else{
if(objj_msgSend(_9c,"stringValue")==="AM"&&_98==12){
_98=0;
}
}
objj_msgSend(_95,"_mutableDate").setHours(_98);
_98=_9b;
}else{
if(objj_msgSend(activeDateSegment,"dateType")==10){
var _99=objj_msgSend(_95,"maxAMPM");
var _9a=objj_msgSend(_95,"minAMPM");
if(_98==_99||_98<_9a){
_98=_99;
var _9d="PM";
var _9e=objj_msgSend(_95,"_mutableDate").getHours();
if(_9e<12){
_9e=_9e+12;
}
}else{
if(_98==_9a||_98>_99){
_98=_9a;
var _9d="AM";
var _9e=objj_msgSend(_95,"_mutableDate").getHours();
if(_9e>11){
_9e=_9e-12;
}
}
}
objj_msgSend(_95,"_mutableDate").setHours(_9e);
objj_msgSend(activeDateSegment,"setStringValue:",_9d);
objj_msgSend(objj_msgSend(_95,"_theStepper"),"setIntValue:",_98);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:userInfo:","datePickerDidChangeNotification",superController,nil);
return;
}
}
}
}
}
}
objj_msgSend(activeDateSegment,"setStringValue:",_98);
objj_msgSend(_theStepper,"setIntValue:",objj_msgSend(activeDateSegment,"stringValue"));
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:userInfo:","datePickerDidChangeNotification",superController,nil);
}
})]);
var _1=objj_allocateClassPair(CPTextField,"DateSegment"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("inputManager"),new objj_ivar("superController"),new objj_ivar("dateType"),new objj_ivar("focusedBackground")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("inputManager"),function(_9f,_a0){
with(_9f){
return inputManager;
}
}),new objj_method(sel_getUid("setInputManager:"),function(_a1,_a2,_a3){
with(_a1){
inputManager=_a3;
}
}),new objj_method(sel_getUid("superController"),function(_a4,_a5){
with(_a4){
return superController;
}
}),new objj_method(sel_getUid("setSuperController:"),function(_a6,_a7,_a8){
with(_a6){
superController=_a8;
}
}),new objj_method(sel_getUid("dateType"),function(_a9,_aa){
with(_a9){
return dateType;
}
}),new objj_method(sel_getUid("setDateType:"),function(_ab,_ac,_ad){
with(_ab){
dateType=_ad;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_ae,_af,_b0){
with(_ae){
_ae=objj_msgSendSuper({receiver:_ae,super_class:objj_getClass("DateSegment").super_class},"initWithFrame:",_b0);
if(_ae){
focusedBackground=objj_msgSend(CPColor,"colorWithPatternImage:",objj_msgSend(objj_msgSend(CPThreePartImage,"alloc"),"initWithImageSlices:isVertical:",[objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Resources/DatePicker/date-segment-left.png",CGSizeMake(4,18)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Resources/DatePicker/date-segment-center.png",CGSizeMake(1,18)),objj_msgSend(objj_msgSend(CPImage,"alloc"),"initByReferencingFile:size:","Resources/DatePicker/date-segment-right.png",CGSizeMake(4,18))],NO));
objj_msgSend(_ae,"setValue:forThemeAttribute:",CPRightTextAlignment,"alignment");
}
return _ae;
}
}),new objj_method(sel_getUid("mouseDown:"),function(_b1,_b2,_b3){
with(_b1){
objj_msgSend(inputManager,"setActiveDateSegment:",_b1);
objj_msgSend(objj_msgSend(superController,"_theStepper"),"setIntValue:",objj_msgSend(_b1,"stringValue"));
if(objj_msgSend(_b1,"dateType")==10&&objj_msgSend(_b1,"stringValue")==="AM"){
objj_msgSend(objj_msgSend(superController,"_theStepper"),"setIntValue:",0);
}else{
if(objj_msgSend(_b1,"dateType")==10&&objj_msgSend(_b1,"stringValue")==="PM"){
objj_msgSend(objj_msgSend(superController,"_theStepper"),"setIntValue:",1);
}
}
}
}),new objj_method(sel_getUid("setStringValue:"),function(_b4,_b5,_b6){
with(_b4){
objj_msgSendSuper({receiver:_b4,super_class:objj_getClass("DateSegment").super_class},"setStringValue:",_b6);
if(objj_msgSend(inputManager,"activeDateSegment")===_b4){
objj_msgSend(objj_msgSend(superController,"_theStepper"),"setDoubleValue:",objj_msgSend(_b4,"intValue"));
if(objj_msgSend(_b4,"dateType")==10&&objj_msgSend(_b4,"stringValue")=="PM"){
objj_msgSend(objj_msgSend(superController,"_theStepper"),"setDoubleValue:",1);
}
}
}
}),new objj_method(sel_getUid("sendNewInput:"),function(_b7,_b8,_b9){
with(_b7){
var _ba=nil;
if(objj_msgSend(_b7,"dateType")==1){
_ba=objj_msgSend(_b7,"numMonthDateInput:",_b9);
objj_msgSend(superController,"_mutableDate").setMonth(_ba-1);
}else{
if(objj_msgSend(_b7,"dateType")==2){
_ba=objj_msgSend(_b7,"numDayDateInput:",_b9);
objj_msgSend(superController,"_mutableDate").setDate(_ba);
}else{
if(objj_msgSend(_b7,"dateType")==3){
_ba=objj_msgSend(_b7,"fullYearDateInput:",_b9);
objj_msgSend(superController,"_mutableDate").setFullYear(_ba);
}else{
if(objj_msgSend(_b7,"dateType")==8){
_ba=objj_msgSend(_b7,"fullMinutesInput:",_b9);
objj_msgSend(superController,"_mutableDate").setMinutes(_ba);
}else{
if(objj_msgSend(_b7,"dateType")==9){
_ba=objj_msgSend(_b7,"fullHoursInput:",_b9);
var _bb=objj_msgSend(objj_msgSend(superController,"segments"),"objectAtIndex:",objj_msgSend(objj_msgSend(superController,"segments"),"count")-1);
if(objj_msgSend(_bb,"stringValue")==="PM"&&_ba!==12){
var hrs=_ba+12;
}else{
if(objj_msgSend(_bb,"stringValue")==="AM"&&_ba==12){
var hrs=0;
}else{
hrs=_ba;
}
}
objj_msgSend(superController,"_mutableDate").setHours(hrs);
}else{
if(objj_msgSend(_b7,"dateType")==10){
_ba=objj_msgSend(_b7,"fullAMPMInput:",_b9);
var _bc=objj_msgSend(objj_msgSend(objj_msgSend(superController,"segments"),"objectAtIndex:",0),"intValue")-1;
if(_ba=="PM"){
_bc=_bc+12;
}
objj_msgSend(superController,"_mutableDate").setHours(_bc);
}
}
}
}
}
}
objj_msgSend(_b7,"setStringValue:",_ba);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:userInfo:","datePickerDidChangeNotification",superController,nil);
}
}),new objj_method(sel_getUid("makeActive"),function(_bd,_be){
with(_bd){
objj_msgSend(_bd,"setBackgroundColor:",focusedBackground);
objj_msgSend(objj_msgSend(superController,"_theStepper"),"setDoubleValue:",objj_msgSend(_bd,"intValue"));
}
}),new objj_method(sel_getUid("makeInactive"),function(_bf,_c0){
with(_bf){
objj_msgSend(_bf,"setBackgroundColor:",objj_msgSend(CPColor,"whiteColor"));
if(objj_msgSend(_bf,"dateType")==10){
return;
}
var _c1=objj_msgSend(_bf,"stringValue");
if(_c1==0&&objj_msgSend(_bf,"dateType")!==8){
_c1=1;
}
if(objj_msgSend(_bf,"dateType")==1){
objj_msgSend(_bf,"setStringValue:",objj_msgSend(_bf,"singleNumber:",_c1));
}else{
if(objj_msgSend(_bf,"dateType")==2){
objj_msgSend(_bf,"setStringValue:",objj_msgSend(_bf,"doubleNumber:",_c1));
}else{
if(objj_msgSend(_bf,"dateType")==3){
objj_msgSend(_bf,"setStringValue:",objj_msgSend(_bf,"quadNumber:",_c1));
}else{
if(objj_msgSend(_bf,"dateType")==8){
objj_msgSend(_bf,"setStringValue:",objj_msgSend(_bf,"doubleNumber:",_c1));
}else{
if(objj_msgSend(_bf,"dateType")==9){
objj_msgSend(_bf,"setStringValue:",objj_msgSend(_bf,"singleNumber:",_c1));
}
}
}
}
}
}
}),new objj_method(sel_getUid("increment"),function(_c2,_c3){
with(_c2){
if(objj_msgSend(_c2,"dateType")==10){
if(objj_msgSend(_c2,"stringValue")=="AM"){
objj_msgSend(objj_msgSend(superController,"_theStepper"),"setDoubleValue:",1);
}else{
objj_msgSend(objj_msgSend(superController,"_theStepper"),"setDoubleValue:",0);
}
}else{
objj_msgSend(objj_msgSend(superController,"_theStepper"),"setDoubleValue:",objj_msgSend(_c2,"intValue")+1);
}
objj_msgSend(objj_msgSend(superController,"_theStepper"),"sendAction:to:",sel_getUid("stepperAction:"),inputManager);
}
}),new objj_method(sel_getUid("decrement"),function(_c4,_c5){
with(_c4){
if(objj_msgSend(_c4,"dateType")==10){
if(objj_msgSend(_c4,"stringValue")=="AM"){
objj_msgSend(_c4,"setStringValue:","PM");
objj_msgSend(objj_msgSend(superController,"_theStepper"),"setDoubleValue:",1);
}else{
objj_msgSend(_c4,"setStringValue:","AM");
objj_msgSend(objj_msgSend(superController,"_theStepper"),"setDoubleValue:",0);
}
}else{
objj_msgSend(objj_msgSend(superController,"_theStepper"),"setDoubleValue:",objj_msgSend(_c4,"intValue")-1);
}
objj_msgSend(objj_msgSend(superController,"_theStepper"),"sendAction:to:",sel_getUid("stepperAction:"),inputManager);
}
}),new objj_method(sel_getUid("removeLastChar"),function(_c6,_c7){
with(_c6){
var _c8=objj_msgSend(_c6,"stringValue");
if(objj_msgSend(_c8,"length")>0){
var _c9=objj_msgSend(_c8,"stringByPaddingToLength:withString:startingAtIndex:",objj_msgSend(_c8,"length")-1,"",1);
objj_msgSend(_c6,"setStringValue:",_c9);
}
}
}),new objj_method(sel_getUid("description"),function(_ca,_cb){
with(_ca){
switch(objj_msgSend(_ca,"dateType")){
case 1:
return "number month field";
case 2:
return "number day field";
case 3:
return "full number year field";
case 4:
return "short name month field";
case 5:
return "short year field";
case 6:
return "day of week short";
case 7:
return "day of week long";
case 8:
return "minutes field";
case 9:
return "hours field";
case 10:
return "am-pm field";
case 11:
return "seconds field";
default:
return "date segment field";
}
}
})]);
var _1=objj_getClass("DateSegment");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"DateSegment\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("numMonthDateInput:"),function(_cc,_cd,_ce){
with(_cc){
var _cf=objj_msgSend(superController,"maxMonth");
var _d0=objj_msgSend(_cc,"stringValue");
var _d1=objj_msgSend(_ce,"characterAtIndex:",0);
if(objj_msgSend(objj_msgSend(_d0,"stringByAppendingString:",_d1),"intValue")>_cf){
var _d2=_d1;
}else{
if(objj_msgSend(objj_msgSend(_d0,"stringByAppendingString:",_d1),"intValue")<=_cf){
var _d2=objj_msgSend(_d0,"stringByAppendingString:",_d1);
}else{
var _d2=(objj_msgSend(_d1,"intValue"))?objj_msgSend(_d1,"intValue"):"";
}
}
return objj_msgSend(_d2,"intValue");
}
}),new objj_method(sel_getUid("numDayDateInput:"),function(_d3,_d4,_d5){
with(_d3){
var _d6=objj_msgSend(superController,"maxDays");
var _d7=objj_msgSend(_d3,"stringValue");
var _d8=objj_msgSend(_d5,"characterAtIndex:",0);
if(objj_msgSend(objj_msgSend(_d7,"stringByAppendingString:",_d8),"intValue")>_d6){
var _d9=_d8;
}else{
if(objj_msgSend(objj_msgSend(_d7,"stringByAppendingString:",_d8),"intValue")<=_d6){
var _d9=objj_msgSend(_d7,"stringByAppendingString:",_d8);
}else{
var _d9=(objj_msgSend(_d8,"intValue"))?objj_msgSend(_d8,"intValue"):"";
}
}
return objj_msgSend(_d9,"intValue");
}
}),new objj_method(sel_getUid("fullYearDateInput:"),function(_da,_db,_dc){
with(_da){
var _dd=objj_msgSend(superController,"maxYear");
var _de=objj_msgSend(_da,"stringValue");
var _df=objj_msgSend(_dc,"characterAtIndex:",0);
if(objj_msgSend(objj_msgSend(_de,"stringByAppendingString:",_df),"intValue")>_dd){
var _e0=_df;
}else{
if(objj_msgSend(objj_msgSend(_de,"stringByAppendingString:",_df),"intValue")<=_dd){
var _e0=objj_msgSend(_de,"stringByAppendingString:",_df);
}else{
var _e0=(objj_msgSend(_df,"intValue"))?objj_msgSend(_df,"intValue"):"";
}
}
return objj_msgSend(_e0,"intValue");
}
}),new objj_method(sel_getUid("fullMinutesInput:"),function(_e1,_e2,_e3){
with(_e1){
var _e4=objj_msgSend(superController,"maxMins");
var _e5=objj_msgSend(_e1,"stringValue");
var _e6=objj_msgSend(_e3,"characterAtIndex:",0);
if(objj_msgSend(objj_msgSend(_e5,"stringByAppendingString:",_e6),"intValue")>_e4){
var _e7=_e6;
}else{
if(objj_msgSend(objj_msgSend(_e5,"stringByAppendingString:",_e6),"intValue")<=_e4){
var _e7=objj_msgSend(_e5,"stringByAppendingString:",_e6);
}else{
var _e7=(objj_msgSend(_e6,"intValue"))?objj_msgSend(_e6,"intValue"):"";
}
}
return objj_msgSend(_e7,"intValue");
}
}),new objj_method(sel_getUid("fullHoursInput:"),function(_e8,_e9,_ea){
with(_e8){
var _eb=objj_msgSend(superController,"maxHours");
var _ec=objj_msgSend(_e8,"stringValue");
var _ed=objj_msgSend(_ea,"characterAtIndex:",0);
if(objj_msgSend(objj_msgSend(_ec,"stringByAppendingString:",_ed),"intValue")>_eb){
var _ee=_ed;
}else{
if(objj_msgSend(objj_msgSend(_ec,"stringByAppendingString:",_ed),"intValue")<=_eb){
var _ee=objj_msgSend(_ec,"stringByAppendingString:",_ed);
}else{
var _ee=(objj_msgSend(_ed,"intValue"))?objj_msgSend(_ed,"intValue"):"";
}
}
return objj_msgSend(_ee,"intValue");
}
}),new objj_method(sel_getUid("fullAMPMInput:"),function(_ef,_f0,_f1){
with(_ef){
var _f2=objj_msgSend(_ef,"stringValue");
var _f3=objj_msgSend(_f1,"characterAtIndex:",0);
if(_f3==="p"||_f3==="P"){
return "PM";
}else{
if(_f3==="a"||_f3==="A"){
return "AM";
}else{
return _f2;
}
}
}
}),new objj_method(sel_getUid("singleNumber:"),function(_f4,_f5,_f6){
with(_f4){
return _f6;
}
}),new objj_method(sel_getUid("doubleNumber:"),function(_f7,_f8,_f9){
with(_f7){
if(objj_msgSend(_f9,"class")===CPNumber){
var _fa=objj_msgSend(objj_msgSend(_f9,"stringValue"),"length");
}else{
var _fa=objj_msgSend(_f9,"length");
}
var _fb="0";
while(_fa<2){
var _f9=objj_msgSend(_fb,"stringByAppendingString:",_f9);
_fa++;
}
return _f9;
}
}),new objj_method(sel_getUid("quadNumber:"),function(_fc,_fd,_fe){
with(_fc){
if(objj_msgSend(_fe,"class")===CPNumber){
var _ff=objj_msgSend(objj_msgSend(_fe,"stringValue"),"length");
}else{
var _ff=objj_msgSend(_fe,"length");
}
var _100="0";
while(_ff<4){
var _fe=objj_msgSend(_100,"stringByAppendingString:",_fe);
_ff++;
}
return _fe;
}
})]);
var _1=objj_allocateClassPair(CPControl,"DatePickerInputManager"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("activeDateSegment"),new objj_ivar("superController")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("activeDateSegment"),function(self,_101){
with(self){
return activeDateSegment;
}
}),new objj_method(sel_getUid("setActiveDateSegment:"),function(self,_102,_103){
with(self){
activeDateSegment=_103;
}
}),new objj_method(sel_getUid("superController"),function(self,_104){
with(self){
return superController;
}
}),new objj_method(sel_getUid("setSuperController:"),function(self,_105,_106){
with(self){
superController=_106;
}
}),new objj_method(sel_getUid("init"),function(self,_107){
with(self){
var _108=CGRectMake(0,0,0,0);
self=objj_msgSendSuper({receiver:self,super_class:objj_getClass("DatePickerInputManager").super_class},"initWithFrame:",_108);
return self;
}
})]);
var _1=objj_getClass("DatePicker");
if(!_1){
throw new SyntaxError("*** Could not find definition for class \"DatePicker\"");
}
var _2=_1.isa;
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(self,_109,_10a){
with(self){
self=objj_msgSendSuper({receiver:self,super_class:objj_getClass("DatePicker").super_class},"initWithCoder:",_10a);
if(self){
objj_msgSend(self,"setDelegate:",objj_msgSend(_10a,"decodeObjectForKey:",datePickerDelegate));
segments=objj_msgSend(_10a,"decodeObjectForKey:",datePickerSegments);
_theView=objj_msgSend(_10a,"decodeObjectForKey:",datePickerView);
_theStepper=objj_msgSend(_10a,"decodeObjectForKey:",datePickerStepper);
objj_msgSend(self,"setDate:",objj_msgSend(_10a,"decodeObjectForKey:",datePickerDate));
objj_msgSend(self,"setNeedsLayout");
objj_msgSend(self,"setNeedsDisplay:",YES);
}
return self;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(self,_10b,_10c){
with(self){
objj_msgSend(_10c,"encodeObject:forKey:",_date,datePickerDate);
objj_msgSend(_10c,"encodeObject:forKey:",segments,datePickerSegments);
objj_msgSend(_10c,"encodeObject:forKey:",_delegate,dataPickerDelegate);
objj_msgSend(_10c,"encodeObject:forKey:",_theView,datePickerView);
objj_msgSend(_10c,"encodeObject:forKey:",_theStepper,datePickerStepper);
}
})]);
p;20;DatePicker/Stepper.jt;4655;@STATIC;1.0;I;18;AppKit/CPControl.jI;17;AppKit/CPButton.jt;4591;
objj_executeFile("AppKit/CPControl.j",NO);
objj_executeFile("AppKit/CPButton.j",NO);
var _1=objj_allocateClassPair(CPControl,"Stepper"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_upButton"),new objj_ivar("_bottomButton"),new objj_ivar("_splitter"),new objj_ivar("_minValue"),new objj_ivar("_maxValue"),new objj_ivar("_increment"),new objj_ivar("_valueWraps"),new objj_ivar("_autorepeat")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("Stepper").super_class},"initWithFrame:",_5);
if(_3){
objj_msgSend(_3,"setMaxValue:",59);
objj_msgSend(_3,"setMinValue:",0);
objj_msgSend(_3,"setIncrement:",1);
objj_msgSend(_3,"setAutorepeat:",YES);
objj_msgSend(_3,"setValueWraps:",YES);
objj_msgSend(_3,"setDoubleValue:",0);
_upButton=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",CGRectMake(0,0,12,10));
_bottomButton=objj_msgSend(objj_msgSend(CPButton,"alloc"),"initWithFrame:",CGRectMake(0,11,12,12));
_splitter=objj_msgSend(objj_msgSend(CPView,"alloc"),"initWithFrame:",CGRectMake(0,10,12,1));
objj_msgSend(_upButton,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Stepper/stepper_up.png",CGSizeMake(12,10)));
objj_msgSend(_bottomButton,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Stepper/stepper_down.png",CGSizeMake(12,12)));
objj_msgSend(_splitter,"setBackgroundColor:",objj_msgSend(objj_msgSend(CPColor,"alloc"),"_initWithPatternImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Stepper/stepper_middle.png",CGSizeMake(12,1))));
objj_msgSend(_upButton,"setAlternateImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Stepper/stepper_up_highlighted.png",CGSizeMake(12,10)));
objj_msgSend(_bottomButton,"setAlternateImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:size:","Resources/Stepper/stepper_down_highlighted.png",CGSizeMake(12,12)));
objj_msgSend(_upButton,"setBordered:",NO);
objj_msgSend(_bottomButton,"setBordered:",NO);
objj_msgSend(_upButton,"setTarget:",_3);
objj_msgSend(_bottomButton,"setTarget:",_3);
objj_msgSend(_upButton,"setContinuous:",YES);
objj_msgSend(_bottomButton,"setContinuous:",YES);
objj_msgSend(_upButton,"setAction:",sel_getUid("buttonUpAction:"));
objj_msgSend(_bottomButton,"setAction:",sel_getUid("buttonDownAction:"));
objj_msgSend(_3,"addSubview:",_upButton);
objj_msgSend(_3,"addSubview:",_splitter);
objj_msgSend(_3,"addSubview:",_bottomButton);
}
return _3;
}
}),new objj_method(sel_getUid("minValue"),function(_6,_7){
with(_6){
return _minValue;
}
}),new objj_method(sel_getUid("setMinValue:"),function(_8,_9,_a){
with(_8){
_minValue=_a;
}
}),new objj_method(sel_getUid("maxValue"),function(_b,_c){
with(_b){
return _maxValue;
}
}),new objj_method(sel_getUid("setMaxValue:"),function(_d,_e,_f){
with(_d){
_maxValue=_f;
}
}),new objj_method(sel_getUid("increment"),function(_10,_11){
with(_10){
return _increment;
}
}),new objj_method(sel_getUid("setIncrement:"),function(_12,_13,_14){
with(_12){
_increment=_14;
}
}),new objj_method(sel_getUid("valueWraps"),function(_15,_16){
with(_15){
return _valueWraps;
}
}),new objj_method(sel_getUid("setValueWraps:"),function(_17,_18,_19){
with(_17){
_valueWraps=_19;
}
}),new objj_method(sel_getUid("autorepeat"),function(_1a,_1b){
with(_1a){
return _autorepeat;
}
}),new objj_method(sel_getUid("setAutorepeat:"),function(_1c,_1d,_1e){
with(_1c){
_autorepeat=_1e;
}
}),new objj_method(sel_getUid("buttonUpAction:"),function(_1f,_20,_21){
with(_1f){
if((objj_msgSend(_1f,"doubleValue")+objj_msgSend(_1f,"increment"))>objj_msgSend(_1f,"maxValue")){
if(objj_msgSend(_1f,"valueWraps")){
objj_msgSend(_1f,"setDoubleValue:",objj_msgSend(_1f,"minValue"));
}
}else{
objj_msgSend(_1f,"setDoubleValue:",objj_msgSend(_1f,"doubleValue")+objj_msgSend(_1f,"increment"));
}
objj_msgSend(_1f,"sendAction:to:",objj_msgSend(_1f,"action"),objj_msgSend(_1f,"target"));
}
}),new objj_method(sel_getUid("buttonDownAction:"),function(_22,_23,_24){
with(_22){
if((objj_msgSend(_22,"doubleValue")-objj_msgSend(_22,"increment"))<objj_msgSend(_22,"minValue")){
if(objj_msgSend(_22,"valueWraps")){
objj_msgSend(_22,"setDoubleValue:",objj_msgSend(_22,"maxValue"));
}
}else{
objj_msgSend(_22,"setDoubleValue:",objj_msgSend(_22,"doubleValue")-objj_msgSend(_22,"increment"));
}
objj_msgSend(_22,"sendAction:to:",objj_msgSend(_22,"action"),objj_msgSend(_22,"target"));
}
})]);
p;22;Test/NewTemplateTest.jt;2081;@STATIC;1.0;I;21;Foundation/CPObject.ji;16;../NewTemplate.jt;2015;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("../NewTemplate.j",YES);
var _1=objj_allocateClassPair(OJTestCase,"NewTemplateTest"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("setUp"),function(_3,_4){
with(_3){
CPLogRegister(CPLogPrint);
}
}),new objj_method(sel_getUid("testOnedayOneTrack"),function(_5,_6){
with(_5){
var _7=new Date(2010,9-1,4);
var _8=new Date(2010,7-1,1);
var _9=objj_msgSend(NewTemplate,"dataonedayonetrack:withFirstDate:",_8,_7);
objj_msgSend(_5,"assertNotNull:",_9);
var _a=JSON.parse(_9);
objj_msgSend(_5,"assert:notSame:",_9,undefined);
objj_msgSend(_5,"assert:notSame:",_a.rootpage,undefined);
objj_msgSend(_5,"assert:same:",_a.rootpage.type,"Navigation");
objj_msgSend(_5,"assert:equals:",_a.rootpage.children[0].subtitle,"Update: 01.07.");
objj_msgSend(_5,"assert:equals:",_a.rootpage.children[2].type,"Navigation");
objj_msgSend(_5,"assert:equals:",_a.rootpage.children[2].title,"Sessions");
objj_msgSend(_5,"assert:equals:",_a.rootpage.children[2].subtitle,"04.09.2010");
}
}),new objj_method(sel_getUid("testThreedaysTwotracks"),function(_b,_c){
with(_b){
var _d=new Date(2010,9-1,30);
var _e=new Date(2010,7-1,1);
var _f=objj_msgSend(NewTemplate,"datathreedaystwotracks:withFirstDate:",_e,_d);
objj_msgSend(_b,"assertNotNull:",_f);
var obj=JSON.parse(_f);
objj_msgSend(_b,"assert:notSame:",_f,undefined);
objj_msgSend(_b,"assert:notSame:",obj.rootpage,undefined);
objj_msgSend(_b,"assert:same:",obj.rootpage.type,"Navigation");
objj_msgSend(_b,"assert:equals:",obj.rootpage.children[0].subtitle,"Update: 01.07.");
objj_msgSend(_b,"assert:equals:",obj.rootpage.children[2].type,"Navigation");
objj_msgSend(_b,"assert:equals:",obj.rootpage.children[2].title,"Day 01");
objj_msgSend(_b,"assert:equals:",obj.rootpage.children[2].subtitle,"30.09.2010");
objj_msgSend(_b,"assert:equals:",obj.rootpage.children[3].subtitle,"01.10.2010");
objj_msgSend(_b,"assert:equals:",obj.rootpage.children[4].subtitle,"02.10.2010");
}
})]);
p;15;Test/PageTest.jt;876;@STATIC;1.0;I;21;Foundation/CPObject.ji;9;../Page.jt;819;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("../Page.j",YES);
var _1=objj_allocateClassPair(OJTestCase,"PageTest"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("page")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("setUp"),function(_3,_4){
with(_3){
page=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andNavigationId:","A Title","A Subtitle","pagetype","anavid");
}
}),new objj_method(sel_getUid("testThatInitializationWorks"),function(_5,_6){
with(_5){
objj_msgSend(_5,"assertNotNull:",page);
objj_msgSend(_5,"assert:equals:",page.title,"A Title");
objj_msgSend(_5,"assert:equals:",page.subtitle,"A Subtitle");
objj_msgSend(_5,"assert:equals:",page.type,"pagetype");
objj_msgSend(_5,"assert:equals:",page.navigationId,"anavid");
}
})]);
e;