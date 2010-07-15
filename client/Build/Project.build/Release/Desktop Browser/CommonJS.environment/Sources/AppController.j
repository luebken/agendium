@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;10;PageView.ji;20;PageViewController.jt;5261;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("Page.j",YES);
objj_executeFile("PageView.j",YES);
objj_executeFile("PageViewController.j",YES);
var _1=objj_allocateClassPair(CPObject,"AppController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("theWindow"),new objj_ivar("box"),new objj_ivar("saveButton"),new objj_ivar("loadButton"),new objj_ivar("previewButton"),new objj_ivar("rootPage"),new objj_ivar("titleLabel"),new objj_ivar("appnameField"),new objj_ivar("pageView"),new objj_ivar("pageViewController"),new objj_ivar("baseURL"),new objj_ivar("appId"),new objj_ivar("listConnection"),new objj_ivar("saveConnection")]);
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
objj_msgSend(titleLabel,"setFont:",objj_msgSend(CPFont,"boldSystemFontOfSize:",24));
baseURL="http://localhost:3000/";
objj_msgSend(box,"setBorderType:",CPLineBorder);
objj_msgSend(box,"setBorderWidth:",1);
objj_msgSend(box,"setBorderColor:",objj_msgSend(CPColor,"grayColor"));
pageViewController=objj_msgSend(objj_msgSend(PageViewController,"alloc"),"initWithCibName:bundle:","PageView",nil);
objj_msgSend(pageViewController,"setPage:",rootPage);
objj_msgSend(objj_msgSend(pageViewController,"view"),"setFrame:",CPRectMake(1,1,500,350));
objj_msgSend(pageView,"addSubview:",objj_msgSend(pageViewController,"view"));
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_8,sel_getUid("pageDidChange:"),"PageChangedNotification",rootPage);
objj_msgSend(previewButton,"setBordered:",NO);
previewButton._DOMElement.style.textDecoration="underline";
objj_msgSend(previewButton,"setTextColor:",objj_msgSend(CPColor,"blueColor"));
objj_msgSend(previewButton,"setTarget:",_8);
objj_msgSend(previewButton,"setAction:",sel_getUid("setWindowLocation"));
previewButton._DOMElement.style.cursor="pointer";
objj_msgSend(_8,"resetData");
objj_msgSend(_8,"myRefresh");
}
}),new objj_method(sel_getUid("setWindowLocation"),function(_a,_b){
with(_a){
var _c=baseURL+"a/"+appId;
window.location=_c;
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
}),new objj_method(sel_getUid("save:"),function(_1c,_1d,_1e){
with(_1c){
console.log("saving...");
var _1f=objj_msgSend(CPURLRequest,"requestWithURL:",baseURL+"agenda");
objj_msgSend(_1f,"setHTTPMethod:","POST");
var _20="{\"_id\":\""+appId+"\", \"rootpage\":"+objj_msgSend(rootPage,"toJSON")+"}";
console.log("Saving JSON: "+_20);
objj_msgSend(_1f,"setHTTPBody:",_20);
objj_msgSend(_1f,"setValue:forHTTPHeaderField:","application/json","Accept");
objj_msgSend(_1f,"setValue:forHTTPHeaderField:","application/json","Content-Type");
saveConnection=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_1f,_1c);
}
}),new objj_method(sel_getUid("connection:didReceiveData:"),function(_21,_22,_23,_24){
with(_21){
console.log("didReceiveData: '"+_24+"'");
if(_23==saveConnection){
alert("Saved!");
}
if(_24!=""){
objj_msgSend(_21,"didReceiveLoadData:",_24);
}else{
alert("Couldn't find Agenda: \""+rootPage.title+"\"");
objj_msgSend(_21,"resetData");
objj_msgSend(_21,"myRefresh");
}
}
}),new objj_method(sel_getUid("didReceiveLoadData:"),function(_25,_26,_27){
with(_25){
try{
var obj=JSON.parse(_27);
var _28=objj_msgSend(Page,"initFromJSONObject:",obj.rootpage);
_25.appId=obj._id;
console.log("data._id:"+obj._id);
objj_msgSend(pageViewController,"setPage:",_28);
objj_msgSend(_25,"myRefresh");
}
catch(e){
console.log("Error in didReceiveData. "+e);
alert(e);
}
}
}),new objj_method(sel_getUid("connection:didFailWithError:"),function(_29,_2a,_2b,_2c){
with(_29){
console.log("didFailWithError: "+_2c);
alert(_2c);
}
}),new objj_method(sel_getUid("connection:didReceiveResponse:"),function(_2d,_2e,_2f,_30){
with(_2d){
console.log("didReceiveResponse for URL:"+objj_msgSend(_30,"URL"));
}
})]);
