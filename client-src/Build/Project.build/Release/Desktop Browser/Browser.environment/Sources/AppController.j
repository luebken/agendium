@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;10;PageView.ji;20;PageViewController.ji;12;LoginPanel.ji;13;NewTemplate.jt;7348;
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
baseURL="http://localhost:3000/";
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
