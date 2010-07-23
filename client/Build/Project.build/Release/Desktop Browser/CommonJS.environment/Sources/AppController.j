@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;10;PageView.ji;20;PageViewController.ji;12;LoginPanel.jt;6061;
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
