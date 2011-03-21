@STATIC;1.0;p;20;AgendiumConnection.jt;6168;@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;8;Config.jt;6101;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("Page.j",YES);
objj_executeFile("Config.j",YES);
var _1=objj_allocateClassPair(CPObject,"AgendiumConnection"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("listConnection"),new objj_ivar("listDelegate"),new objj_ivar("saveConnection"),new objj_ivar("saveDelegate"),new objj_ivar("loginConnection"),new objj_ivar("loginDelegate"),new objj_ivar("checkNameConnection"),new objj_ivar("checkNameDelegate"),new objj_ivar("passwordConnection"),new objj_ivar("passwordDelegate")]);
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
}),new objj_method(sel_getUid("changePassword:toPassword:forUser:delegate:"),function(_11,_12,_13,_14,_15,_16){
with(_11){
CPLog("Requesting to change password for user "+_15);
var _17=objj_msgSend(CPURLRequest,"requestWithURL:",BASEURL+"password/");
objj_msgSend(_17,"setHTTPMethod:","POST");
var _18="{\"oldpassword\":\""+_13+"\",\"newpassword\":\""+_14+"\", \"user\":\""+_15+"\"}";
CPLog("Posting "+_18);
objj_msgSend(_17,"setHTTPBody:",_18);
objj_msgSend(_17,"setValue:forHTTPHeaderField:","application/json","Accept");
objj_msgSend(_17,"setValue:forHTTPHeaderField:","application/json","Content-Type");
passwordConnection=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_17,_11);
passwordDelegate=_16;
}
}),new objj_method(sel_getUid("saveAgenda:rootPage:userid:delegate:"),function(_19,_1a,_1b,_1c,_1d,_1e){
with(_19){
var _1f=objj_msgSend(CPURLRequest,"requestWithURL:",BASEURL+"agenda");
objj_msgSend(_1f,"setHTTPMethod:","POST");
var _20="{\"_id\":\""+_1b+"\",\"userid\":\""+_1d+"\", \"rootpage\":"+objj_msgSend(_1c,"toJSON")+"}";
objj_msgSend(_1f,"setHTTPBody:",_20);
objj_msgSend(_1f,"setValue:forHTTPHeaderField:","application/json","Accept");
objj_msgSend(_1f,"setValue:forHTTPHeaderField:","application/json","Content-Type");
saveConnection=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_1f,_19);
saveDelegate=_1e;
}
}),new objj_method(sel_getUid("checkAppName:forId:delegate:"),function(_21,_22,_23,id,_24){
with(_21){
var _25=objj_msgSend(CPURLRequest,"requestWithURL:",BASEURL+"isnameok/"+_23+"/"+id);
objj_msgSend(_25,"setHTTPMethod:","GET");
checkNameConnection=objj_msgSend(CPURLConnection,"connectionWithRequest:delegate:",_25,_21);
checkNameDelegate=_24;
}
}),new objj_method(sel_getUid("connection:didReceiveData:"),function(_26,_27,_28,_29){
with(_26){
if(_28==saveConnection){
objj_msgSend(_26,"didReceiveSaveData:delegate:",_29,saveDelegate);
}
if(_28==listConnection){
objj_msgSend(_26,"didReceiveLoadData:delegate:",_29,listDelegate);
}
if(_28==loginConnection){
objj_msgSend(_26,"didReceiveLoginData:delegate:",_29,loginDelegate);
}
if(_28==checkNameConnection){
objj_msgSend(_26,"didReceiveCheckNameData:delegate:",_29,checkNameDelegate);
}
if(_28==passwordConnection){
objj_msgSend(_26,"didReceiveChangePassword:delegate:",_29,passwordDelegate);
}
}
}),new objj_method(sel_getUid("connection:didFailWithError:"),function(_2a,_2b,_2c,_2d){
with(_2a){
CPLog("didFailWithError: "+_2d);
alert(_2d);
}
}),new objj_method(sel_getUid("connection:didFailWithError:"),function(_2e,_2f,_30,_31){
with(_2e){
CPLog("didFailWithError: "+_31);
alert(_31);
}
}),new objj_method(sel_getUid("connection:didReceiveResponse:"),function(_32,_33,_34,_35){
with(_32){
CPLog("didReceiveResponse for url:"+objj_msgSend(_35,"URL")+" and status "+objj_msgSend(_35,"statusCode"));
}
}),new objj_method(sel_getUid("didReceiveSaveData:delegate:"),function(_36,_37,_38,_39){
with(_36){
if(_38){
try{
var obj=JSON.parse(_38);
objj_msgSend(_39,"didReceiveAgenda:withRootPage:",obj._id,undefined);
}
catch(e){
objj_msgSend(_39,"failureWhileReceivingAgenda:","Error while parsing Data: "+e);
}
}else{
CPLog("No data");
objj_msgSend(_39,"failureWhileReceivingAgenda:","Couldn't save the Agenda");
}
}
}),new objj_method(sel_getUid("didReceiveLoadData:delegate:"),function(_3a,_3b,_3c,_3d){
with(_3a){
if(_3c!=null&&_3c!=""&&_3c!="null"){
try{
var obj=JSON.parse(_3c);
var _3e=objj_msgSend(Page,"initFromJSONObject:andNavigationId:",obj.rootpage,"r");
objj_msgSend(_3d,"didReceiveAgenda:withRootPage:",obj._id,_3e);
}
catch(e){
objj_msgSend(_3d,"failureWhileReceivingAgenda:","Error while parsing Data: "+e);
}
}else{
CPLog("failureWhileReceivingAgenda");
objj_msgSend(_3d,"failureWhileReceivingAgenda:","Couldn't find the Agenda");
}
}
}),new objj_method(sel_getUid("didReceiveLoginData:delegate:"),function(_3f,_40,_41,_42){
with(_3f){
if(_41&&_41!="undefined"){
var _43=JSON.parse(_41);
objj_msgSend(_42,"loginSuccessFor:withId:andShownIntro:",_43.email,_43._id,new Boolean(_43.shownintro));
}else{
objj_msgSend(_42,"loginFailed");
}
}
}),new objj_method(sel_getUid("didReceiveCheckNameData:delegate:"),function(_44,_45,_46,_47){
with(_44){
objj_msgSend(_47,"didReceiveCheckName:",(_46==="true"));
}
}),new objj_method(sel_getUid("didReceiveChangePassword:delegate:"),function(_48,_49,_4a,_4b){
with(_48){
CPLog("didReceiveChangePassword: "+_4a);
if(_4a!=null&&_4a!=""&&_4a!="null"){
try{
var _4c=JSON.parse(_4a);
if(_4c.changed){
objj_msgSend(_4b,"didChangePassword");
return;
}else{
objj_msgSend(_4b,"didntChangePassword");
return;
}
}
catch(e){
}
}
CPLog("Error didReceiveChangePassword");
objj_msgSend(_4b,"didntChangePassword");
}
})]);
p;15;AppController.jt;9999;@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;10;PageView.ji;20;PageViewController.ji;19;Panels/LoginPanel.ji;18;Panels/OpenPanel.ji;19;Panels/SharePanel.ji;17;Panels/NewPanel.ji;26;Panels/UserSettingsPanel.ji;24;Panels/SelectLogoPanel.ji;19;Panels/IntroPanel.ji;13;NewTemplate.ji;20;AgendiumConnection.ji;8;Config.ji;13;PreviewView.jt;9654;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("Page.j",YES);
objj_executeFile("PageView.j",YES);
objj_executeFile("PageViewController.j",YES);
objj_executeFile("Panels/LoginPanel.j",YES);
objj_executeFile("Panels/OpenPanel.j",YES);
objj_executeFile("Panels/SharePanel.j",YES);
objj_executeFile("Panels/NewPanel.j",YES);
objj_executeFile("Panels/UserSettingsPanel.j",YES);
objj_executeFile("Panels/SelectLogoPanel.j",YES);
objj_executeFile("Panels/IntroPanel.j",YES);
objj_executeFile("NewTemplate.j",YES);
objj_executeFile("AgendiumConnection.j",YES);
objj_executeFile("Config.j",YES);
objj_executeFile("PreviewView.j",YES);
var _1=objj_allocateClassPair(CPObject,"AppController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("theWindow"),new objj_ivar("box"),new objj_ivar("saveButton"),new objj_ivar("loadButton"),new objj_ivar("previewButton"),new objj_ivar("logoutButton"),new objj_ivar("shareButton"),new objj_ivar("previewView"),new objj_ivar("appnameField"),new objj_ivar("appnameProblemLabel"),new objj_ivar("buildDateLabel"),new objj_ivar("pageView"),new objj_ivar("rootPage"),new objj_ivar("pageViewController"),new objj_ivar("aConnection"),new objj_ivar("appId"),new objj_ivar("user"),new objj_ivar("validName"),new objj_ivar("namechanged"),new objj_ivar("nameOKServer")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("user"),function(_3,_4){
with(_3){
return user;
}
}),new objj_method(sel_getUid("setUser:"),function(_5,_6,_7){
with(_5){
user=_7;
}
}),new objj_method(sel_getUid("applicationDidFinishLaunching:"),function(_8,_9,_a){
with(_8){
objj_msgSend(theWindow,"orderOut:",_8);
objj_msgSend(objj_msgSend(objj_msgSend(LoginPanel,"alloc"),"init:",_8),"orderFront:",nil);
}
}),new objj_method(sel_getUid("awakeFromCib"),function(_b,_c){
with(_b){
objj_msgSend(box,"setBorderType:",CPLineBorder);
objj_msgSend(box,"setBorderWidth:",1);
objj_msgSend(box,"setBorderColor:",objj_msgSend(CPColor,"grayColor"));
pageViewController=objj_msgSend(objj_msgSend(PageViewController,"alloc"),"initWithCibName:bundle:","PageView",nil);
objj_msgSend(pageViewController,"setPage:",rootPage);
objj_msgSend(objj_msgSend(pageViewController,"view"),"setFrame:",CPRectMake(1,1,550,501));
objj_msgSend(pageView,"addSubview:",objj_msgSend(pageViewController,"view"));
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_b,sel_getUid("pageDidChange:"),"PageChangedNotification",rootPage);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_b,sel_getUid("save:"),"AddItemToListNotification",nil);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_b,sel_getUid("save:"),"EditingDoneNotification",nil);
objj_msgSend(previewButton,"setBordered:",NO);
previewButton._DOMElement.style.textDecoration="underline";
objj_msgSend(previewButton,"setTextColor:",objj_msgSend(CPColor,"blueColor"));
objj_msgSend(previewButton,"setAlignment:",CPLeftTextAlignment);
objj_msgSend(previewButton,"setTarget:",_b);
objj_msgSend(previewButton,"setAction:",sel_getUid("openMobileApp"));
previewButton._DOMElement.style.cursor="pointer";
objj_msgSend(previewView,"setFrameLoadDelegate:",_b);
objj_msgSend(pageViewController,"setDelegate:",previewView);
objj_msgSend(logoutButton,"setBordered:",NO);
objj_msgSend(logoutButton,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:","Resources/logout2.png"));
logoutButton._DOMElement.style.textDecoration="underline";
logoutButton._DOMElement.style.cursor="pointer";
objj_msgSend(appnameProblemLabel,"setObjectValue:","");
aConnection=objj_msgSend(objj_msgSend(AgendiumConnection,"alloc"),"init");
objj_msgSend(appnameField,"setValue:forThemeAttribute:inState:",objj_msgSend(CPColor,"lightGrayColor"),"text-color",CPTextFieldStatePlaceholder);
objj_msgSend(buildDateLabel,"setObjectValue:",BUILDDATE);
objj_msgSend(_b,"resetData");
objj_msgSend(_b,"validateName");
objj_msgSend(_b,"refreshUIFromData");
}
}),new objj_method(sel_getUid("pageDidChange:"),function(_d,_e,_f){
with(_d){
objj_msgSend(saveButton,"setEnabled:",rootPage.title.length>0);
}
}),new objj_method(sel_getUid("controlTextDidChange:"),function(_10,_11,_12){
with(_10){
namechanged=true;
objj_msgSend(rootPage,"setTitle:",objj_msgSend(appnameField,"objectValue"));
objj_msgSend(_10,"validateName");
objj_msgSend(_10,"refreshUIFromData");
}
}),new objj_method(sel_getUid("validateName"),function(_13,_14){
with(_13){
var _15=objj_msgSend(appnameField,"objectValue");
var _16=objj_msgSend(objj_msgSend(appnameField,"objectValue"),"length");
var _17=/\s/.test(_15);
_13.validName=!(_17|_16<5);
if(_13.validName){
objj_msgSend(aConnection,"checkAppName:forId:delegate:",_15,appId,_13);
}
}
}),new objj_method(sel_getUid("refreshUIFromData"),function(_18,_19){
with(_18){
objj_msgSend(saveButton,"setEnabled:",validName&&nameOKServer);
objj_msgSend(shareButton,"setEnabled:",validName&&nameOKServer);
if(!_18.validName){
var _1a=/\s/.test(rootPage.title);
if(_1a){
objj_msgSend(appnameProblemLabel,"setObjectValue:","< Please remove whitespaces.");
}else{
if(rootPage.title.length<5){
objj_msgSend(appnameProblemLabel,"setObjectValue:","");
}else{
objj_msgSend(appnameProblemLabel,"setObjectValue:","");
}
}
}else{
if(!nameOKServer){
objj_msgSend(appnameProblemLabel,"setObjectValue:","< Name is already taken.");
}else{
objj_msgSend(appnameProblemLabel,"setObjectValue:","");
}
}
objj_msgSend(pageViewController,"myRefresh");
if(appId){
var _1b=BASEURL+"m/"+rootPage.title;
var _1c=BASEURL+"prev/"+appId;
objj_msgSend(previewView,"setMainFrameURL:",_1c);
objj_msgSend(previewButton,"setTitle:",_1b);
objj_msgSend(previewButton,"sizeToFit");
}else{
objj_msgSend(previewButton,"setTitle:","");
objj_msgSend(previewView,"setMainFrameURL:",BASEURL+"preview");
}
}
}),new objj_method(sel_getUid("resetData"),function(_1d,_1e){
with(_1d){
_1d.rootPage=objj_msgSend(objj_msgSend(Page,"alloc"),"init");
_1d.pageViewController.page=rootPage;
_1d.appId=undefined;
_1d.validName=true;
_1d.namechanged=false;
_1d.nameOKServer=true;
objj_msgSend(_1d,"controlTextDidChange:",null);
}
}),new objj_method(sel_getUid("openMobileApp"),function(_1f,_20){
with(_1f){
if(namechanged){
window.alert("Please save before opening the app.");
}else{
var _21=BASEURL+"m/"+rootPage.title;
window.open(_21,"mywindow");
}
}
}),new objj_method(sel_getUid("load:"),function(_22,_23,_24){
with(_22){
var _25=objj_msgSend(appnameField,"objectValue");
objj_msgSend(objj_msgSend(objj_msgSend(OpenPanel,"alloc"),"initWithName:andDelegate:",_25,_22),"orderFront:",nil);
}
}),new objj_method(sel_getUid("login:"),function(_26,_27,_28){
with(_26){
objj_msgSend(objj_msgSend(objj_msgSend(UserSettingsPanel,"alloc"),"init:withUsername:",_26,_26.user.email),"orderFront:",nil);
}
}),new objj_method(sel_getUid("new:"),function(_29,_2a,_2b){
with(_29){
objj_msgSend(objj_msgSend(objj_msgSend(NewPanel,"alloc"),"init:",_29),"orderFront:",nil);
}
}),new objj_method(sel_getUid("save:"),function(_2c,_2d,_2e){
with(_2c){
if(validName&&nameOKServer){
objj_msgSend(aConnection,"saveAgenda:rootPage:userid:delegate:",appId,rootPage,user.id,_2c);
}
}
}),new objj_method(sel_getUid("share:"),function(_2f,_30,_31){
with(_2f){
objj_msgSend(objj_msgSend(objj_msgSend(SharePanel,"alloc"),"init:andAppname:",_2f,rootPage.title),"orderFront:",nil);
}
}),new objj_method(sel_getUid("selectLogo:"),function(_32,_33,_34){
with(_32){
objj_msgSend(objj_msgSend(objj_msgSend(SelectLogoPanel,"alloc"),"initWithUrl:andDelegate:",_32.rootPage.logourl,_32),"orderFront:",nil);
}
}),new objj_method(sel_getUid("didReceiveAgenda:withRootPage:"),function(_35,_36,_37,_38){
with(_35){
_35.appId=_37;
if(_38){
_35.rootPage=_38;
objj_msgSend(appnameField,"setObjectValue:",_38.title);
objj_msgSend(pageViewController,"setPage:",_38);
}
namechanged=false;
objj_msgSend(_35,"validateName");
objj_msgSend(_35,"refreshUIFromData");
}
}),new objj_method(sel_getUid("didReceiveCheckName:"),function(_39,_3a,_3b){
with(_39){
_39.nameOKServer=_3b;
objj_msgSend(_39,"refreshUIFromData");
}
}),new objj_method(sel_getUid("webView:didFinishLoadForFrame:"),function(_3c,_3d,_3e,_3f){
with(_3c){
var _40=pageViewController.page.navigationId;
objj_msgSend(previewView,"changePageTo:animate:reverse:",_40,NO,NO);
objj_msgSend(objj_msgSend(previewView,"windowScriptObject"),"evaluateWebScript:","removeEventsForPreview();");
}
}),new objj_method(sel_getUid("failureWhileReceivingAgenda:"),function(_41,_42,msg){
with(_41){
alert(msg);
}
}),new objj_method(sel_getUid("panelDidClose:data:"),function(_43,_44,tag,_45){
with(_43){
switch(tag){
case "login":
_43.user=_45;
objj_msgSend(theWindow,"orderFront:",_43);
objj_msgSend(objj_msgSend(objj_msgSend(IntroPanel,"alloc"),"initWithDelegate:",_43),"orderFront:",nil);
break;
case "open":
CPLog("Loading Agenda for "+_43.user.id+" and name "+_45);
objj_msgSend(aConnection,"loadAgendaFor:andName:withDelegate:",_43.user.id,_45,_43);
break;
case "empty":
objj_msgSend(appnameField,"setObjectValue:","");
objj_msgSend(_43,"resetData");
objj_msgSend(_43,"didReceiveAgenda:withRootPage:",undefined,undefined);
break;
case "threedaytwotracks":
case "onedayonetrack":
objj_msgSend(appnameField,"setObjectValue:","");
objj_msgSend(_43,"resetData");
var obj=JSON.parse(objj_msgSend(NewTemplate,"jsonDataForTemplate:withStartingDate:",tag,_45));
var _46=objj_msgSend(Page,"initFromJSONObject:andNavigationId:",obj.rootpage,"r");
objj_msgSend(_43,"didReceiveAgenda:withRootPage:",undefined,_46);
break;
case "logout":
history.go(-1);
break;
case "setlogo":
_43.rootPage.logourl=_45;
break;
}
}
})]);
p;12;Config-dev.jt;75;@STATIC;1.0;t;58;
BASEURL="http://localhost:8000/";
BUILDDATE="vDEVBUILD";
p;13;Config-prod.jt;50;@STATIC;1.0;t;33;
BASEURL="http://touchium.com/";
p;8;Config.jt;82;@STATIC;1.0;t;65;
BASEURL="http://touchium.com/";
BUILDDATE="v20110321-23:39:29";
p;6;main.jt;267;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jt;181;
objj_executeFile("Foundation/Foundation.j",NO);
objj_executeFile("AppKit/AppKit.j",NO);
objj_executeFile("AppController.j",YES);
main=function(_1,_2){
CPApplicationMain(_1,_2);
};
p;13;NewTemplate.jt;10370;@STATIC;1.0;I;21;Foundation/CPObject.jt;10324;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
var _2=["Mon","Tue","Wed","Thu","Fri","Sat","Sun"];
var _3=objj_allocateClassPair(CPObject,"NewTemplate"),_4=_3.isa;
objj_registerClassPair(_3);
class_addMethods(_4,[new objj_method(sel_getUid("stantardDateFormat:"),function(_5,_6,dt){
with(_5){
var _7=_2[(dt.getDay()+6)%7];
return objj_msgSend(CPString,"stringWithFormat:","%s, %02d %s %04d",_7,dt.getDate(),_1[dt.getMonth()],dt.getFullYear());
}
}),new objj_method(sel_getUid("dateFormatForUpdate:"),function(_8,_9,dt){
with(_8){
return objj_msgSend(CPString,"stringWithFormat:","Update: %02d. %s.",dt.getDate(),_1[dt.getMonth()]);
}
}),new objj_method(sel_getUid("jsonDataForTemplate:withStartingDate:"),function(_a,_b,_c,_d){
with(_a){
if(_c=="onedayonetrack"){
return objj_msgSend(NewTemplate,"dataonedayonetrack:withFirstDate:",new Date(),_d);
}else{
return objj_msgSend(NewTemplate,"datathreedaystwotracks:withFirstDate:",new Date(),_d);
}
}
}),new objj_method(sel_getUid("dataonedayonetrack:withFirstDate:"),function(_e,_f,now,_10){
with(_e){
var _11=objj_msgSend(NewTemplate,"stantardDateFormat:",_10);
var _12=objj_msgSend(NewTemplate,"dateFormatForUpdate:",now);
var _13={rootpage:{type:"Navigation",title:"",children:[{type:"Detail",title:"News",subtitle:_12,children:[],attributes:[{"key":"Info","value":"This is a perfect place to put in some information about agenda changes."}]},{type:"Group",title:"Conference",subtitle:"",children:[]},{type:"Navigation",title:"Sessions",subtitle:_11,children:[{type:"Detail",title:"A great session",subtitle:"9:00 - 10:30 in Room 1",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"A great session",subtitle:"11:00 - 12:30 in Room 2",attributes:[],children:[]},{type:"Detail",title:"A great session",subtitle:"14:00 - 15:30 in Room 3",attributes:[],children:[]}]},{type:"Group",title:"",subtitle:"",children:[]},{type:"Navigation",title:"Infos",subtitle:"General information",children:[]}]}};
return JSON.stringify(_13);
}
}),new objj_method(sel_getUid("datathreedaystwotracks:withFirstDate:"),function(_14,_15,now,_16){
with(_14){
var _17=objj_msgSend(NewTemplate,"stantardDateFormat:",_16);
_16.setDate(_16.getDate()+1);
var _18=objj_msgSend(NewTemplate,"stantardDateFormat:",_16);
_16.setDate(_16.getDate()+1);
var _19=objj_msgSend(NewTemplate,"stantardDateFormat:",_16);
var _1a=objj_msgSend(NewTemplate,"dateFormatForUpdate:",now);
var _1b={rootpage:{type:"Navigation",title:"",children:[{type:"Detail",title:"News",subtitle:_1a,children:[],attributes:[{"key":"Info","value":"This is a perfect place to put in some information about agenda changes."}]},{type:"Group",title:"Conference",subtitle:"",children:[]},{type:"Navigation",title:"Day 01",subtitle:_17,children:[{type:"Group",title:"Morning",subtitle:"",children:[]},{type:"Detail",title:"First Session",subtitle:"Track A | 9:00-10:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Second Session",subtitle:"Track B | 9:00-10:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Third Session",subtitle:"Track A | 10:45-11:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Fourth Session",subtitle:"Track B | 10:45-11:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Lunch",subtitle:"11:30-13:00",attributes:[{"key":"Location","value":"Get great food and drinks down in the main area."},{"key":"Exhibition","value":"Walk around the exhibition and meet great people."}],children:[]},{type:"Group",title:"Afternoon",subtitle:"",children:[]},{type:"Detail",title:"Fifth Session",subtitle:"Track A | 13:00-14:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Sixth Session",subtitle:"Track B | 13:00-14:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Seventh Session",subtitle:"Track A | 15:00-16:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Eigth Session",subtitle:"Track B | 15:00-16:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},]},{type:"Navigation",title:"Day 02",subtitle:_18,children:[{type:"Group",title:"Morning",subtitle:"",children:[]},{type:"Detail",title:"First Session",subtitle:"Track A | 9:00-10:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Second Session",subtitle:"Track B | 9:00-10:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Third Session",subtitle:"Track A | 10:45-11:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Fourth Session",subtitle:"Track B | 10:45-11:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Lunch",subtitle:"11:30-13:00",attributes:[{"key":"Location","value":"Get great food and drinks down in the main area."},{"key":"Exhibition","value":"Walk around the exhibition and meet great people."}],children:[]},{type:"Group",title:"Afternoon",subtitle:"",children:[]},{type:"Detail",title:"Fifth Session",subtitle:"Track A | 13:00-14:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Sixth Session",subtitle:"Track B | 13:00-14:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Seventh Session",subtitle:"Track A | 15:00-16:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Eigth Session",subtitle:"Track B | 15:00-16:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},]},{type:"Navigation",title:"Day 03",subtitle:_19,children:[{type:"Group",title:"Morning",subtitle:"",children:[]},{type:"Detail",title:"First Session",subtitle:"Track A | 9:00-10:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Second Session",subtitle:"Track B | 9:00-10:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Third Session",subtitle:"Track A | 10:45-11:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Fourth Session",subtitle:"Track B | 10:45-11:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Lunch",subtitle:"11:30-13:00",attributes:[{"key":"Location","value":"Get great food and drinks down in the main area."},{"key":"Exhibition","value":"Walk around the exhibition and meet great people."}],children:[]},{type:"Group",title:"Afternoon",subtitle:"",children:[]},{type:"Detail",title:"Fifth Session",subtitle:"Track A | 13:00-14:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Sixth Session",subtitle:"Track B | 13:00-14:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Seventh Session",subtitle:"Track A | 15:00-16:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},{type:"Detail",title:"Eigth Session",subtitle:"Track B | 15:00-16:30",attributes:[{"key":"Speaker","value":"Some speaker"},{"key":"Desc","value":"A detailed description about his session"},{"key":"Link","value":"http://www.agendium.de"}],children:[]},]},{type:"Group",title:"",subtitle:"",children:[]},{type:"Navigation",title:"Infos",subtitle:"General information",children:[]}]}};
return JSON.stringify(_1b);
}
})]);
p;6;Page.jt;5890;@STATIC;1.0;I;21;Foundation/CPObject.jt;5845;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"Page"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("title"),new objj_ivar("subtitle"),new objj_ivar("logourl"),new objj_ivar("children"),new objj_ivar("type"),new objj_ivar("attributes"),new objj_ivar("navigationId"),new objj_ivar("ancestor")]);
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
}),new objj_method(sel_getUid("logourl"),function(_d,_e){
with(_d){
return logourl;
}
}),new objj_method(sel_getUid("setLogourl:"),function(_f,_10,_11){
with(_f){
logourl=_11;
}
}),new objj_method(sel_getUid("children"),function(_12,_13){
with(_12){
return children;
}
}),new objj_method(sel_getUid("setChildren:"),function(_14,_15,_16){
with(_14){
children=_16;
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
}),new objj_method(sel_getUid("navigationId"),function(_21,_22){
with(_21){
return navigationId;
}
}),new objj_method(sel_getUid("setNavigationId:"),function(_23,_24,_25){
with(_23){
navigationId=_25;
}
}),new objj_method(sel_getUid("ancestor"),function(_26,_27){
with(_26){
return ancestor;
}
}),new objj_method(sel_getUid("setAncestor:"),function(_28,_29,_2a){
with(_28){
ancestor=_2a;
}
}),new objj_method(sel_getUid("init"),function(_2b,_2c){
with(_2b){
_2b=objj_msgSendSuper({receiver:_2b,super_class:objj_getClass("Page").super_class},"init");
objj_msgSend(_2b,"initWithTitle:andSubtitle:andType:andLogourl:andNavigationId:","","","Navigation","","r");
return _2b;
}
}),new objj_method(sel_getUid("initWithTitle:andSubtitle:andType:andLogourl:andNavigationId:"),function(_2d,_2e,_2f,_30,_31,_32,_33){
with(_2d){
_2d=objj_msgSendSuper({receiver:_2d,super_class:objj_getClass("Page").super_class},"init");
_2d.title=_2f;
_2d.subtitle=_30;
_2d.type=_31;
_2d.logourl=_32;
_2d.navigationId=_33;
_2d.children=objj_msgSend(objj_msgSend(CPArray,"alloc"),"init");
_2d.attributes=objj_msgSend(objj_msgSend(CPArray,"alloc"),"init");
return _2d;
}
}),new objj_method(sel_getUid("isRootPage"),function(_34,_35){
with(_34){
return ancestor==null;
}
}),new objj_method(sel_getUid("addChild:atIndex:"),function(_36,_37,_38,_39){
with(_36){
objj_msgSend(_38,"setAncestor:",_36);
if(_39<0){
_39=children.length;
}
objj_msgSend(children,"insertObject:atIndex:",_38,_39);
}
}),new objj_method(sel_getUid("duplicateChild:"),function(_3a,_3b,_3c){
with(_3a){
var _3d=objj_msgSend(children,"objectAtIndex:",_3c);
var _3e=objj_msgSend(_3d,"deepCopy");
objj_msgSend(_3a,"addChild:atIndex:",_3e,_3c+1);
}
}),new objj_method(sel_getUid("removeChild:"),function(_3f,_40,_41){
with(_3f){
objj_msgSend(children,"removeObjectAtIndex:",_41);
}
}),new objj_method(sel_getUid("deepCopy"),function(_42,_43){
with(_42){
var _44=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andLogourl:andNavigationId:",_42.title,_42.subtitle,_42.type,_42.logourl,_42.navigationId);
for(var i=0;i<children.length;i++){
var _45=objj_msgSend(children[i],"deepCopy");
objj_msgSend(_44,"addChild:atIndex:",_45,i);
}
for(var i=0;i<attributes.length;i++){
objj_msgSend(objj_msgSend(_44,"attributes"),"insertObject:atIndex:",attributes[i],i);
}
return _44;
}
}),new objj_method(sel_getUid("duplicateChild:"),function(_46,_47,_48){
with(_46){
var _49=objj_msgSend(children,"objectAtIndex:",_48);
var _4a=objj_msgSend(_49,"deepCopy");
objj_msgSend(_46,"addChild:atIndex:",_4a,_48+1);
}
}),new objj_method(sel_getUid("toJSON"),function(_4b,_4c){
with(_4b){
var _4d="";
for(var i=0;i<children.length;i++){
_4d+=objj_msgSend(children[i],"toJSON");
_4d+=",";
}
if(_4d.length>0){
_4d=_4d.substring(0,_4d.length-1);
}
var _4e="";
for(var i=0;i<attributes.length;i++){
_4e+="{\"key\":\""+attributes[i].key+"\"";
_4e+=",\"value\":\""+attributes[i].value+"\"}";
_4e+=",";
}
if(_4e.length>0){
_4e=_4e.substring(0,_4e.length-1);
}
var _4f="{\"title\":\""+title;
if(subtitle){
_4f+="\",\"subtitle\":\""+subtitle;
}
if(logourl){
_4f+="\",\"logourl\":\""+logourl;
}
_4f+="\",\"type\":\""+type+"\",\"children\":["+_4d+"],\"attributes\":["+_4e+"]}";
return _4f;
}
}),new objj_method(sel_getUid("description"),function(_50,_51){
with(_50){
return title;
}
}),new objj_method(sel_getUid("isEqual:"),function(_52,_53,_54){
with(_52){
if(!objj_msgSend(_54,"isKindOfClass:",objj_msgSend(Page,"class"))){
return NO;
}
if(_54.title!=_52.title){
return NO;
}
if(_54.subtitle!=_52.subtitle){
return NO;
}
if(_54.type!=_52.type){
return NO;
}
return YES;
}
}),new objj_method(sel_getUid("isNavigationType"),function(_55,_56){
with(_55){
return type==="Navigation";
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("initFromJSONObject:andNavigationId:"),function(_57,_58,_59,_5a){
with(_57){
var _5b=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andLogourl:andNavigationId:",_59.title,_59.subtitle,_59.type,_59.logourl,_5a);
for(var i=0;i<_59.children.length;i++){
var _5c=_5a+"c"+i;
var _5d=objj_msgSend(Page,"initFromJSONObject:andNavigationId:",_59.children[i],_5c);
objj_msgSend(_5b,"addChild:atIndex:",_5d,-1);
}
if(_59.attributes){
for(var i=0;i<_59.attributes.length;i++){
var _5e=_59.attributes[i];
objj_msgSend(objj_msgSend(_5b,"attributes"),"insertObject:atIndex:",_5e,i);
}
}
return _5b;
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
p;20;PageViewController.jt;9827;@STATIC;1.0;I;21;Foundation/CPObject.ji;19;LPKit/LPSlideView.ji;19;Table/TMTableView.jt;9734;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("LPKit/LPSlideView.j",YES);
objj_executeFile("Table/TMTableView.j",YES);
var _1=objj_allocateClassPair(CPViewController,"PageViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("scrollView"),new objj_ivar("addButton"),new objj_ivar("backButton"),new objj_ivar("editButton"),new objj_ivar("itemtypeButton"),new objj_ivar("titleField"),new objj_ivar("slideView"),new objj_ivar("delegate"),new objj_ivar("table"),new objj_ivar("page"),new objj_ivar("editing")]);
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
}),new objj_method(sel_getUid("initTable"),function(_d,_e){
with(_d){
_d.table=objj_msgSend(objj_msgSend(TMTableView,"alloc"),"initWithFrame:",CGRectMake(0,0,320,650));
objj_msgSend(table,"setDataSource:",_d);
objj_msgSend(table,"setDelegate:",_d);
}
}),new objj_method(sel_getUid("awakeFromCib"),function(_f,_10){
with(_f){
objj_msgSend(_f,"initTable");
objj_msgSend(scrollView,"setDocumentView:",table);
objj_msgSend(backButton,"setEnabled:",NO);
objj_msgSend(itemtypeButton,"removeAllItems");
_f.editing=NO;
objj_msgSend(titleField,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(titleField,"setValue:forThemeAttribute:",CPCenterTextAlignment,"alignment");
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_f,sel_getUid("rowClicked:"),"RowClickedNotification",nil);
}
}),new objj_method(sel_getUid("setDelegate:"),function(_11,_12,_13){
with(_11){
_11.delegate=_13;
}
}),new objj_method(sel_getUid("tableView:shouldEditTableColumn:row:"),function(_14,_15,_16,_17,row){
with(_14){
objj_msgSend(_14,"setEditing:",NO);
objj_msgSend(_14,"toggleEditing:",_16);
return YES;
}
}),new objj_method(sel_getUid("toggleEditing:"),function(_18,_19,_1a){
with(_18){
var _1b;
if(_18.editing){
objj_msgSend(_18,"setEditing:",NO);
objj_msgSend(editButton,"setTitle:","Edit");
objj_msgSend(editButton,"unsetThemeState:",CPThemeStateDefault);
_1b=objj_msgSend(CPTextField,"labelWithTitle:","");
objj_msgSend(_1b,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(_1b,"setVerticalAlignment:",CPCenterTextAlignment);
objj_msgSend(_1b,"setLineBreakMode:",CPLineBreakByWordWrapping);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:","EditingDoneNotification",nil);
}else{
objj_msgSend(_18,"setEditing:",YES);
objj_msgSend(editButton,"setTitle:","Done");
objj_msgSend(editButton,"setThemeState:",CPThemeStateDefault);
_1b=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","",100);
}
var _1c=objj_msgSend(table,"tableColumns");
objj_msgSend(_1c[1],"setDataView:",_1b);
objj_msgSend(_1c[2],"setDataView:",_1b);
objj_msgSend(_18,"myRefresh");
}
}),new objj_method(sel_getUid("numberOfRowsInTableView:"),function(_1d,_1e,_1f){
with(_1d){
if(objj_msgSend(page,"isNavigationType")){
return objj_msgSend(objj_msgSend(page,"children"),"count");
}else{
return objj_msgSend(objj_msgSend(page,"attributes"),"count");
}
}
}),new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"),function(_20,_21,_22,_23,row){
with(_20){
if(objj_msgSend(page,"isNavigationType")){
var _24=objj_msgSend(objj_msgSend(page,"children"),"objectAtIndex:",row);
var _25=YES;
switch(objj_msgSend(_23,"identifier")){
case "zero":
return _24.type;
case "first":
return _24.title;
case "second":
return _24.subtitle;
case "button2":
_25=_24.type!=="Group"&&editing;
return {row:row,visible:_25,editing:editing,column:objj_msgSend(_23,"identifier")};
default:
_25=_24.type!=="Group";
return {row:row,visible:_25,editing:editing,column:objj_msgSend(_23,"identifier")};
}
}else{
var _26=objj_msgSend(objj_msgSend(page,"attributes"),"objectAtIndex:",row);
var key=_26.key;
var _27=_26.value;
switch(objj_msgSend(_23,"identifier")){
case "zero":
return "Text";
case "first":
return key;
case "second":
return _27;
default:
return {visible:NO,row:row,editing:editing,column:objj_msgSend(_23,"identifier")};
}
}
}
}),new objj_method(sel_getUid("tableView:setObjectValue:forTableColumn:row:"),function(_28,_29,_2a,_2b,_2c,row){
with(_28){
if(objj_msgSend(page,"isNavigationType")){
var _2d=objj_msgSend(objj_msgSend(page,"children"),"objectAtIndex:",row);
if(objj_msgSend(objj_msgSend(_2c,"identifier"),"isEqual:","first")){
objj_msgSend(_2d,"setTitle:",_2b);
}else{
objj_msgSend(_2d,"setSubtitle:",_2b);
}
}else{
var _2e=objj_msgSend(objj_msgSend(page,"attributes"),"objectAtIndex:",row);
if(objj_msgSend(objj_msgSend(_2c,"identifier"),"isEqual:","first")){
_2e.key=_2b;
}else{
_2e.value=_2b;
}
}
objj_msgSend(table,"reloadData");
}
}),new objj_method(sel_getUid("tableView:isGroupRow:"),function(_2f,_30,_31,row){
with(_2f){
return YES;
}
}),new objj_method(sel_getUid("addItemToList:"),function(_32,_33,_34){
with(_32){
var _35=objj_msgSend(table,"selectedRow");
if(objj_msgSend(page,"isNavigationType")){
if(_35<0){
_35=page.children.length;
}
var _36=objj_msgSend(objj_msgSend(itemtypeButton,"selectedItem"),"title");
var _37;
var _38=page.navigationId+"c"+_35;
if(_36=="Navigationpage"){
_37=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andNavigationId:","Title of a navigation page","The optional subtitle","Navigation",_38);
}else{
if(_36=="Detailpage"){
_37=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andNavigationId:","Title of a detail page","The optional subtitle","Detail",_38);
}else{
_37=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andNavigationId:","A group title","","Group",_38);
}
}
objj_msgSend(page,"addChild:atIndex:",_37,_35);
}else{
if(_35<0){
_35=page.attributes.length;
}
var _39={key:"A key",value:"A value"};
objj_msgSend(objj_msgSend(page,"attributes"),"insertObject:atIndex:",_39,_35);
}
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:","AddItemToListNotification",nil);
objj_msgSend(table,"reloadData");
}
}),new objj_method(sel_getUid("deleteItemFromList:"),function(_3a,_3b,row){
with(_3a){
if(objj_msgSend(page,"isNavigationType")){
objj_msgSend(page,"removeChild:",row);
}else{
objj_msgSend(objj_msgSend(page,"attributes"),"removeObjectAtIndex:",row);
}
objj_msgSend(table,"deselectAll");
objj_msgSend(table,"reloadData");
}
}),new objj_method(sel_getUid("duplicateItemFromList:"),function(_3c,_3d,row){
with(_3c){
if(objj_msgSend(page,"isNavigationType")){
objj_msgSend(page,"duplicateChild:",row);
}else{
}
objj_msgSend(table,"deselectAll");
objj_msgSend(table,"reloadData");
}
}),new objj_method(sel_getUid("rowClicked:"),function(_3e,_3f,_40){
with(_3e){
var o=JSON.parse(objj_msgSend(_40,"object"));
var row=o.row;
var _41=o.column;
if(!objj_msgSend(_3e,"editing")){
var _42=page.navigationId;
page=objj_msgSend(objj_msgSend(page,"children"),"objectAtIndex:",row);
var _43=objj_msgSend(objj_msgSend(slideView,"subviews")[0],"bounds");
var _44=objj_msgSend(objj_msgSend(CPScrollView,"alloc"),"initWithFrame:",_43);
objj_msgSend(_3e,"initTable");
objj_msgSend(_44,"setDocumentView:",table);
objj_msgSend(slideView,"addSubview:",_44);
objj_msgSend(slideView,"slideToView:",_44);
objj_msgSend(_3e,"myRefresh");
objj_msgSend(delegate,"changePageTo:animate:reverse:",page.navigationId,YES,NO);
}else{
if(_41==="button1"){
objj_msgSend(_3e,"deleteItemFromList:",row);
}else{
objj_msgSend(_3e,"duplicateItemFromList:",row);
}
}
}
}),new objj_method(sel_getUid("animationDidEnd:"),function(_45,_46,_47){
with(_45){
CPLog("animationDidEnd");
}
}),new objj_method(sel_getUid("backButtonClicked:"),function(_48,_49,_4a){
with(_48){
var _4b=page.navigationId;
page=objj_msgSend(page,"ancestor");
var _4c=objj_msgSend(objj_msgSend(slideView,"subviews")[0],"bounds");
var _4d=objj_msgSend(objj_msgSend(CPScrollView,"alloc"),"initWithFrame:",_4c);
objj_msgSend(_48,"initTable");
objj_msgSend(_4d,"setDocumentView:",table);
objj_msgSend(slideView,"addSubview:",_4d);
objj_msgSend(slideView,"slideToView:direction:",_4d,LPSlideViewNegativeDirection);
objj_msgSend(delegate,"changePageTo:animate:reverse:",page.navigationId,YES,YES);
objj_msgSend(_48,"myRefresh");
}
}),new objj_method(sel_getUid("myRefresh"),function(_4e,_4f){
with(_4e){
objj_msgSend(table,"reloadData");
objj_msgSend(backButton,"setEnabled:",page.ancestor!=null);
objj_msgSend(table,"deselectAll");
var _50=page.title;
if(page.subtitle){
_50+=" / "+page.subtitle;
}
if(!page.title){
_50="Untitled";
}
if(!objj_msgSend(page,"isRootPage")){
_50+=" ("+page.type+")";
}
objj_msgSend(titleField,"setObjectValue:",_50);
var _51=objj_msgSend(objj_msgSend(itemtypeButton,"selectedItem"),"title");
objj_msgSend(itemtypeButton,"removeAllItems");
var _52=objj_msgSend(objj_msgSend(table,"tableColumns")[0],"headerView");
var _53=objj_msgSend(objj_msgSend(table,"tableColumns")[1],"headerView");
var _54=objj_msgSend(objj_msgSend(table,"tableColumns")[2],"headerView");
var _55;
objj_msgSend(_52,"setStringValue:","Type");
if(objj_msgSend(page,"isNavigationType")){
objj_msgSend(_53,"setStringValue:","Title");
objj_msgSend(_54,"setStringValue:","Subtitle");
_55=["Navigationpage","Detailpage","Group"];
}else{
objj_msgSend(_53,"setStringValue:","Attribute");
objj_msgSend(_54,"setStringValue:","Value");
_55=["Text"];
}
objj_msgSend(itemtypeButton,"addItemsWithTitles:",_55);
if(objj_msgSend(_55,"containsObject:",_51)){
objj_msgSend(itemtypeButton,"selectItemWithTitle:",_51);
}
}
})]);
p;13;PreviewView.jt;989;@STATIC;1.0;I;21;Foundation/CPObject.jt;945;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPWebView,"PreviewView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithCoder:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("PreviewView").super_class},"initWithCoder:",_5)){
objj_msgSend(_3,"setFrame:",CPRectMake(540,100,340,520));
_3._DOMElement.style.webkitTransformOrigin="10 10";
_3._DOMElement.style.webkitTransform="scale(0.75)";
_3._iframe.style.width="455px";
_3._iframe.style.height="680px";
}
return _3;
}
}),new objj_method(sel_getUid("changePageTo:animate:reverse:"),function(_6,_7,_8,_9,_a){
with(_6){
var _b=_9?"slide":"none";
var _c="if($.mobile.activePage.attr('id') != $('#"+_8+"').attr('id')) $.mobile.changePage($('#"+_8+"'), '"+_b+"', "+_a+")";
CPLog("cmd "+_c);
objj_msgSend(objj_msgSend(_6,"windowScriptObject"),"evaluateWebScript:",_c);
}
})]);
p;19;LPKit/LPSlideView.jt;5255;@STATIC;1.0;I;15;AppKit/CPView.ji;17;LPViewAnimation.jt;5194;
objj_executeFile("AppKit/CPView.j",NO);
objj_executeFile("LPViewAnimation.j",YES);
LPSlideViewHorizontalDirection=0;
LPSlideViewVerticalDirection=1;
LPSlideViewPositiveDirection=2;
LPSlideViewNegativeDirection=4;
var _1=objj_allocateClassPair(CPView,"LPSlideView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("slideDirection"),new objj_ivar("currentView"),new objj_ivar("previousView"),new objj_ivar("animationDuration"),new objj_ivar("animationCurve"),new objj_ivar("isSliding"),new objj_ivar("_delegate")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("slideDirection"),function(_3,_4){
with(_3){
return slideDirection;
}
}),new objj_method(sel_getUid("setSlideDirection:"),function(_5,_6,_7){
with(_5){
slideDirection=_7;
}
}),new objj_method(sel_getUid("currentView"),function(_8,_9){
with(_8){
return currentView;
}
}),new objj_method(sel_getUid("setCurrentView:"),function(_a,_b,_c){
with(_a){
currentView=_c;
}
}),new objj_method(sel_getUid("previousView"),function(_d,_e){
with(_d){
return previousView;
}
}),new objj_method(sel_getUid("setPreviousView:"),function(_f,_10,_11){
with(_f){
previousView=_11;
}
}),new objj_method(sel_getUid("animationDuration"),function(_12,_13){
with(_12){
return animationDuration;
}
}),new objj_method(sel_getUid("setAnimationDuration:"),function(_14,_15,_16){
with(_14){
animationDuration=_16;
}
}),new objj_method(sel_getUid("animationCurve"),function(_17,_18){
with(_17){
return animationCurve;
}
}),new objj_method(sel_getUid("setAnimationCurve:"),function(_19,_1a,_1b){
with(_19){
animationCurve=_1b;
}
}),new objj_method(sel_getUid("isSliding"),function(_1c,_1d){
with(_1c){
return isSliding;
}
}),new objj_method(sel_getUid("delegate"),function(_1e,_1f){
with(_1e){
return _delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_20,_21,_22){
with(_20){
_delegate=_22;
}
}),new objj_method(sel_getUid("initWithFrame:"),function(_23,_24,_25){
with(_23){
if(_23=objj_msgSendSuper({receiver:_23,super_class:objj_getClass("LPSlideView").super_class},"initWithFrame:",_25)){
animationCurve=CPAnimationEaseOut;
slideDirection=LPSlideViewHorizontalDirection;
animationDuration=0.5;
isSliding=NO;
}
return _23;
}
}),new objj_method(sel_getUid("addSubview:"),function(_26,_27,_28){
with(_26){
if(!currentView){
currentView=_28;
}else{
objj_msgSend(_28,"setHidden:",YES);
}
objj_msgSend(_28,"setFrame:",objj_msgSend(_26,"bounds"));
objj_msgSend(_28,"setAutoresizingMask:",CPViewWidthSizable|CPViewHeightSizable);
objj_msgSendSuper({receiver:_26,super_class:objj_getClass("LPSlideView").super_class},"addSubview:",_28);
}
}),new objj_method(sel_getUid("slideToView:"),function(_29,_2a,_2b){
with(_29){
objj_msgSend(_29,"slideToView:direction:animationProgress:",_2b,nil,nil);
}
}),new objj_method(sel_getUid("slideToView:direction:"),function(_2c,_2d,_2e,_2f){
with(_2c){
objj_msgSend(_2c,"slideToView:direction:animationProgress:",_2e,_2f,nil);
}
}),new objj_method(sel_getUid("slideToView:direction:animationProgress:"),function(_30,_31,_32,_33,_34){
with(_30){
if(_32==currentView||isSliding){
return;
}
isSliding=YES;
if(_delegate&&objj_msgSend(_delegate,"respondsToSelector:",sel_getUid("slideView:willMoveToView:"))){
objj_msgSend(_delegate,"slideView:willMoveToView:",_30,_32);
}
var _35=objj_msgSend(objj_msgSend(_30,"subviews"),"indexOfObject:",_32),_36=objj_msgSend(objj_msgSend(_30,"subviews"),"indexOfObject:",currentView),_37=objj_msgSend(_30,"frame").size;
objj_msgSend(_32,"setHidden:",NO);
var _38=CGPointMake(0,0),_39=CGPointMake(0,0);
if(slideDirection==LPSlideViewHorizontalDirection){
var _3a,_3b;
if((_33&&_33==LPSlideViewNegativeDirection)||(!_33&&_35<_36)){
_3a=-_37.width;
_3b=_37.width;
}
if((_33&&_33==LPSlideViewPositiveDirection)||(!_33&&_35>_36)){
_3a=_37.width;
_3b=-_37.width;
}
_38.x=_3a;
_39.x=_3b;
}else{
if(slideDirection==LPSlideViewVerticalDirection){
var _3c,_3d;
if((_33&&_33==LPSlideViewNegativeDirection)||(!_33&&_35>_36)){
_3c=_37.height;
_3d=-_37.height;
}
if((_33&&_33==LPSlideViewPositiveDirection)||(!_33&&_35<_36)){
_3c=-_37.height;
_3d=_37.height;
}
_38.y=_3c;
_39.y=_3d;
if(_34){
_38.y-=(_34*_38.y);
_39.y-=(_34*_39.y);
}
}
}
var _3e=objj_msgSend(objj_msgSend(LPViewAnimation,"alloc"),"initWithViewAnimations:",[{"target":_32,"animations":[[LPOriginAnimationKey,_38,CGPointMake(0,0)]]},{"target":currentView,"animations":[[LPOriginAnimationKey,CGPointMakeZero(),_39]]}]);
objj_msgSend(_3e,"setAnimationCurve:",animationCurve);
objj_msgSend(_3e,"setDuration:",animationDuration);
objj_msgSend(_3e,"setDelegate:",_30);
objj_msgSend(_3e,"startAnimation");
previousView=currentView;
currentView=_32;
}
}),new objj_method(sel_getUid("animationDidEnd"),function(_3f,_40){
with(_3f){
if(_delegate&&objj_msgSend(_delegate,"respondsToSelector:",sel_getUid("slideView:didMoveToView:"))){
objj_msgSend(_delegate,"slideView:didMoveToView:",_3f,currentView);
}
objj_msgSend(previousView,"setHidden:",YES);
isSliding=NO;
}
}),new objj_method(sel_getUid("animationDidEnd:"),function(_41,_42,_43){
with(_41){
objj_msgSend(_41,"animationDidEnd");
}
}),new objj_method(sel_getUid("animationDidStop:"),function(_44,_45,_46){
with(_44){
objj_msgSend(_44,"animationDidEnd");
}
})]);
p;23;LPKit/LPViewAnimation.jt;8134;@STATIC;1.0;I;21;Foundation/CPObject.jt;8089;
objj_executeFile("Foundation/CPObject.j",NO);
LPCSSAnimationsAreAvailable=NO;
var _1=["webkit","Moz","moz","o","ms"],_2=nil;
LPFadeAnimationKey="LPFadeAnimation";
LPFrameAnimationKey="LPFrameAnimation";
LPOriginAnimationKey="LPOriginAnimation";
LPTestCSSFeature=function(_3){
if(typeof document==="undefined"){
return NO;
}
if(!_2){
_2=document.createElement("div");
}
var _4=[_3];
for(var i=0;i<_1.length;i++){
_4.push(_1[i]+_3);
}
for(var i=0;i<_4.length;i++){
if(typeof _2.style[_4[i]]!=="undefined"){
return YES;
}
}
return NO;
};
LPCSSAnimationsAreAvailable=LPTestCSSFeature("AnimationName");
var _5=function(_6,_7,_8,_9){
if(_9){
_6.style[_8]=_6.style[_8]+", "+_7;
}else{
_6.style[_8]=_7;
}
};
var _a=objj_allocateClassPair(CPAnimation,"LPViewAnimation"),_b=_a.isa;
class_addIvars(_a,[new objj_ivar("_isAnimating"),new objj_ivar("_viewAnimations"),new objj_ivar("_animationDidEndTimeout"),new objj_ivar("_shouldUseCSSAnimations"),new objj_ivar("_c1"),new objj_ivar("_c2")]);
objj_registerClassPair(_a);
class_addMethods(_a,[new objj_method(sel_getUid("viewAnimations"),function(_c,_d){
with(_c){
return _viewAnimations;
}
}),new objj_method(sel_getUid("setViewAnimations:"),function(_e,_f,_10){
with(_e){
_viewAnimations=_10;
}
}),new objj_method(sel_getUid("shouldUseCSSAnimations"),function(_11,_12){
with(_11){
return _shouldUseCSSAnimations;
}
}),new objj_method(sel_getUid("setShouldUseCSSAnimations:"),function(_13,_14,_15){
with(_13){
_shouldUseCSSAnimations=_15;
}
}),new objj_method(sel_getUid("initWithViewAnimations:"),function(_16,_17,_18){
with(_16){
if(_16=objj_msgSend(_16,"initWithDuration:animationCurve:",1,CPAnimationLinear)){
_isAnimating=NO;
_viewAnimations=_18;
_shouldUseCSSAnimations=NO;
}
return _16;
}
}),new objj_method(sel_getUid("setAnimationCurve:"),function(_19,_1a,_1b){
with(_19){
objj_msgSendSuper({receiver:_19,super_class:objj_getClass("LPViewAnimation").super_class},"setAnimationCurve:",_1b);
_c1=[];
_c2=[];
objj_msgSend(_timingFunction,"getControlPointAtIndex:values:",1,_c1);
objj_msgSend(_timingFunction,"getControlPointAtIndex:values:",2,_c2);
}
}),new objj_method(sel_getUid("startAnimation"),function(_1c,_1d){
with(_1c){
if(LPCSSAnimationsAreAvailable&&_shouldUseCSSAnimations){
if(_isAnimating){
return;
}
_isAnimating=YES;
var i=_viewAnimations.length;
while(i--){
var _1e=_viewAnimations[i],_1f=_1e["target"];
objj_msgSend(_1c,"target:setCSSAnimationDuration:",_1f,_duration);
objj_msgSend(_1c,"target:setCSSAnimationCurve:",_1f,_animationCurve);
var x=_1e["animations"].length;
while(x--){
var _20=_1e["animations"][x],_21=_20[0],_22=_20[1],end=_20[2];
if(_21===LPFadeAnimationKey){
objj_msgSend(_1f,"setAlphaValue:",_22);
objj_msgSend(_1c,"target:addCSSAnimationPropertyForKey:append:",_1f,_21,x!==0);
setTimeout(function(_23,_24){
_23._DOMElement.style["-webkit-transform"]="translate3d(0px, 0px, 0px)";
objj_msgSend(_23,"setAlphaValue:",_24);
},0,_1f,end);
}else{
if(_21===LPOriginAnimationKey){
if(!CGPointEqualToPoint(_22,end)){
objj_msgSend(_1f,"setFrameOrigin:",_22);
objj_msgSend(_1c,"target:addCSSAnimationPropertyForKey:append:",_1f,_21,x!==0);
setTimeout(function(_25,_26,_27){
var x=_27.x-_26.x,y=_27.y-_26.y;
_25._DOMElement.style["-webkit-transform"]="translate3d("+x+"px, "+y+"px, 0px)";
setTimeout(function(){
objj_msgSend(_1c,"_clearCSS");
_25._DOMElement.style["-webkit-transform"]="translate3d(0px, 0px, 0px)";
objj_msgSend(_25,"setFrameOrigin:",_27);
},(1000*_duration)+100);
},0,_1f,_22,end);
}
}else{
if(_21===LPFrameAnimationKey){
CPLog.error("LPViewAnimation does not currently support CSS frame animations. This should fall back to the regular javascript animation.");
}
}
}
}
}
if(_animationDidEndTimeout){
clearTimeout(_animationDidEndTimeout);
}
_animationDidEndTimeout=setTimeout(function(_28){
_isAnimating=NO;
objj_msgSend(_28,"_clearCSS");
if(objj_msgSend(_delegate,"respondsToSelector:",sel_getUid("animationDidEnd:"))){
objj_msgSend(_delegate,"animationDidEnd:",_28);
}
},(1000*_duration)+100,_1c);
}else{
var i=_viewAnimations.length;
while(i--){
var _1e=_viewAnimations[i],_1f=_1e["target"];
var x=_1e["animations"].length;
while(x--){
var _20=_1e["animations"][x],_21=_20[0],_22=_20[1],end=_20[2];
switch(_21){
case LPFadeAnimationKey:
objj_msgSend(_1f,"setAlphaValue:",_22);
break;
case LPOriginAnimationKey:
objj_msgSend(_1f,"setFrameOrigin:",_22);
break;
case LPFrameAnimationKey:
objj_msgSend(_1f,"setFrame:",_22);
break;
}
}
}
objj_msgSendSuper({receiver:_1c,super_class:objj_getClass("LPViewAnimation").super_class},"startAnimation");
}
}
}),new objj_method(sel_getUid("setCurrentProgress:"),function(_29,_2a,_2b){
with(_29){
_progress=_2b;
var _2c=_2d(_progress,_c1[0],_c1[1],_c2[0],_c2[1],_duration),i=_viewAnimations.length;
while(i--){
var _2e=_viewAnimations[i],_2f=_2e["target"],x=_2e["animations"].length;
while(x--){
var _30=_2e["animations"][x],_31=_30[0],_32=_30[1],end=_30[2];
switch(_31){
case LPFadeAnimationKey:
objj_msgSend(_2f,"setAlphaValue:",(_2c*(end-_32))+_32);
break;
case LPOriginAnimationKey:
objj_msgSend(_2f,"setFrameOrigin:",CGPointMake(_32.x+(_2c*(end.x-_32.x)),_32.y+(_2c*(end.y-_32.y))));
break;
case LPFrameAnimationKey:
objj_msgSend(_2f,"setFrame:",CGRectMake(_32.origin.x+(_2c*(end.origin.x-_32.origin.x)),_32.origin.y+(_2c*(end.origin.y-_32.origin.y)),_32.size.width+(_2c*(end.size.width-_32.size.width)),_32.size.height+(_2c*(end.size.height-_32.size.height))));
}
}
}
}
}),new objj_method(sel_getUid("isAnimating"),function(_33,_34){
with(_33){
if(LPCSSAnimationsAreAvailable&&_shouldUseCSSAnimations){
return _isAnimating;
}else{
return objj_msgSendSuper({receiver:_33,super_class:objj_getClass("LPViewAnimation").super_class},"isAnimating");
}
}
}),new objj_method(sel_getUid("stopAnimation"),function(_35,_36){
with(_35){
if(LPCSSAnimationsAreAvailable&&_shouldUseCSSAnimations){
}else{
objj_msgSendSuper({receiver:_35,super_class:objj_getClass("LPViewAnimation").super_class},"stopAnimation");
}
}
}),new objj_method(sel_getUid("_clearCSS"),function(_37,_38){
with(_37){
for(var i=0;i<_viewAnimations.length;i++){
_viewAnimations[i]["target"]._DOMElement.style["-webkit-transition-property"]="none";
}
}
}),new objj_method(sel_getUid("target:setCSSAnimationDuration:"),function(_39,_3a,_3b,_3c){
with(_39){
_3b._DOMElement.style["-webkit-transition-duration"]=_3c+"s";
}
}),new objj_method(sel_getUid("target:setCSSAnimationCurve:"),function(_3d,_3e,_3f,_40){
with(_3d){
var _41=nil;
switch(_40){
case CPAnimationLinear:
_41="linear";
break;
case CPAnimationEaseIn:
_41="ease-in";
break;
case CPAnimationEaseOut:
_41="ease-out";
break;
case CPAnimationEaseInOut:
_41="ease-in-out";
break;
}
_3f._DOMElement.style["-webkit-transition-timing-function"]=_41;
}
}),new objj_method(sel_getUid("target:addCSSAnimationPropertyForKey:append:"),function(_42,_43,_44,_45,_46){
with(_42){
var _47=nil;
switch(_45){
case LPFadeAnimationKey:
_47="-webkit-transform, opacity";
break;
case LPOriginAnimationKey:
_47="-webkit-transform";
break;
case LPFrameAnimationKey:
_47="top, left, width, height";
break;
default:
_47="none";
}
_5(_44._DOMElement,_47,"-webkit-transition-property",_46);
}
})]);
var _2d=_2d=function(t,p1x,p1y,p2x,p2y,_48){
var ax=0,bx=0,cx=0,ay=0,by=0,cy=0;
sampleCurveX=function(t){
return ((ax*t+bx)*t+cx)*t;
};
sampleCurveY=function(t){
return ((ay*t+by)*t+cy)*t;
};
sampleCurveDerivativeX=function(t){
return (3*ax*t+2*bx)*t+cx;
};
solveEpsilon=function(_49){
return 1/(200*_49);
};
solve=function(x,_4a){
return sampleCurveY(solveCurveX(x,_4a));
};
solveCurveX=function(x,_4b){
var t0,t1,t2,x2,d2,i;
fabs=function(n){
if(n>=0){
return n;
}else{
return 0-n;
}
};
for(t2=x,i=0;i<8;i++){
x2=sampleCurveX(t2)-x;
if(fabs(x2)<_4b){
return t2;
}
d2=sampleCurveDerivativeX(t2);
if(fabs(d2)<0.000001){
break;
}
t2=t2-x2/d2;
}
t0=0;
t1=1;
t2=x;
if(t2<t0){
return t0;
}
if(t2>t1){
return t1;
}
while(t0<t1){
x2=sampleCurveX(t2);
if(fabs(x2-x)<_4b){
return t2;
}
if(x>x2){
t0=t2;
}else{
t1=t2;
}
t2=(t1-t0)*0.5+t0;
}
return t2;
};
cx=3*p1x;
bx=3*(p2x-p1x)-cx;
ax=1-cx-bx;
cy=3*p1y;
by=3*(p2y-p1y)-cy;
ay=1-cy-by;
return solve(t,solveEpsilon(_48));
};
p;19;Panels/IntroPanel.jt;1980;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.jt;1914;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("AppKit/CPPanel.j",NO);
var _1=objj_allocateClassPair(CPPanel,"IntroPanel"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("imageView")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithDelegate:"),function(_3,_4,_5){
with(_3){
_3=objj_msgSend(_3,"initWithContentRect:styleMask:",CGRectMake(100,30,490,380),CPHUDBackgroundWindowMask);
if(_3){
_3.delegate=_5;
objj_msgSend(_3,"setTitle:","Welcome to Touchium");
objj_msgSend(_3,"setFloatingPanel:",YES);
var _6=objj_msgSend(_3,"contentView"),_7=objj_msgSend(_6,"bounds");
var _8=objj_msgSend(CPTextField,"labelWithTitle:","How to get started:");
objj_msgSend(_8,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(_8,"sizeToFit");
objj_msgSend(_8,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_8,"setFrameOrigin:",CGPointMake(5,5));
objj_msgSend(_6,"addSubview:",_8);
var _9=objj_msgSend(objj_msgSend(CPImageView,"alloc"),"initWithFrame:",CGRectMake(5,25,475,325));
objj_msgSend(_9,"setImageScaling:",CPScaleNone);
objj_msgSend(_9,"setImage:",objj_msgSend(objj_msgSend(CPImage,"alloc"),"initWithContentsOfFile:","Resources/intro4.png"));
objj_msgSend(_6,"addSubview:",_9);
var _a=objj_msgSend(CPButton,"buttonWithTitle:theme:","Close",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_a,"setFrame:",CGRectMake(220,355,70,20));
objj_msgSend(_6,"addSubview:",_a);
objj_msgSend(_a,"setTag:","introclose");
objj_msgSend(_a,"setTarget:",_3);
objj_msgSend(_a,"setAction:",sel_getUid("buttonAction:"));
}
return _3;
}
}),new objj_method(sel_getUid("buttonAction:"),function(_b,_c,_d){
with(_b){
if(objj_msgSend(delegate,"respondsToSelector:",sel_getUid("panelDidClose:data:"))){
objj_msgSend(delegate,"panelDidClose:data:",objj_msgSend(_d,"tag"),undefined);
}
objj_msgSend(_b,"close");
}
})]);
p;19;Panels/LoginPanel.jt;4692;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.jt;4626;
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
}),new objj_method(sel_getUid("loginSuccessFor:withId:andShownIntro:"),function(_15,_16,_17,_18,_19){
with(_15){
CPLog("loginSuccessFor shownintro:"+_19);
if(objj_msgSend(delegate,"respondsToSelector:",sel_getUid("panelDidClose:data:"))){
objj_msgSend(delegate,"panelDidClose:data:","login",{"id":_18,"email":_17,"shownintro":_19});
objj_msgSend(_15,"close");
}
}
}),new objj_method(sel_getUid("loginFailed"),function(_1a,_1b){
with(_1a){
objj_msgSend(titleLabel,"setObjectValue:","Login failed. Please try again.");
}
}),new objj_method(sel_getUid("signup"),function(_1c,_1d){
with(_1c){
window.open("https://spreadsheets.google.com/viewform?formkey=dFJWN29DR09fanRfRnVic255Z1hVMEE6MQ","_self");
}
})]);
p;17;Panels/NewPanel.jt;3646;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.ji;23;DatePicker/DatePicker.jt;3552;
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
p;18;Panels/OpenPanel.jt;2416;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.jt;2350;
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
p;24;Panels/SelectLogoPanel.jt;2427;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.jt;2361;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("AppKit/CPPanel.j",NO);
var _1=objj_allocateClassPair(CPPanel,"SelectLogoPanel"),_2=_1.isa;
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
}),new objj_method(sel_getUid("initWithUrl:andDelegate:"),function(_8,_9,_a,_b){
with(_8){
_8=objj_msgSend(_8,"initWithContentRect:styleMask:",CGRectMake(200,150,330,140),CPHUDBackgroundWindowMask);
if(_8){
_8.delegate=_b;
objj_msgSend(_8,"setTitle:","Select Logo");
objj_msgSend(_8,"setFloatingPanel:",YES);
var _c=objj_msgSend(_8,"contentView"),_d=objj_msgSend(_c,"bounds");
var _e=objj_msgSend(CPTextField,"labelWithTitle:","Enter the URL of your mobile logo:");
objj_msgSend(_e,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(_e,"sizeToFit");
objj_msgSend(_e,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_e,"setFrameOrigin:",CGPointMake(45,5));
objj_msgSend(_c,"addSubview:",_e);
field=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:",_a,"",300);
objj_msgSend(field,"setFrameOrigin:",CGPointMake(15,35));
objj_msgSend(_c,"addSubview:",field);
var _f=objj_msgSend(CPButton,"buttonWithTitle:theme:","Set",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_f,"setFrame:",CGRectMake(250,90,70,20));
objj_msgSend(_c,"addSubview:",_f);
objj_msgSend(_f,"setTag:","setlogo");
objj_msgSend(_f,"setTarget:",_8);
objj_msgSend(_f,"setAction:",sel_getUid("buttonAction:"));
var _10=objj_msgSend(CPButton,"buttonWithTitle:theme:","Cancel",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_10,"setFrame:",CGRectMake(170,90,70,20));
objj_msgSend(_c,"addSubview:",_10);
objj_msgSend(_10,"setTag:","cancellogo");
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
p;19;Panels/SharePanel.jt;2876;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.jt;2810;
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
p;26;Panels/UserSettingsPanel.jt;5901;@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.jt;5835;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("AppKit/CPPanel.j",NO);
var _1=objj_allocateClassPair(CPPanel,"UserSettingsPanel"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate"),new objj_ivar("titleLabel"),new objj_ivar("oldPasswordField"),new objj_ivar("passwordField"),new objj_ivar("passwordField2"),new objj_ivar("errorLabel"),new objj_ivar("username"),new objj_ivar("aConnection")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("delegate"),function(_3,_4){
with(_3){
return delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_5,_6,_7){
with(_5){
delegate=_7;
}
}),new objj_method(sel_getUid("init:withUsername:"),function(_8,_9,_a,_b){
with(_8){
_8=objj_msgSend(_8,"initWithContentRect:styleMask:",CGRectMake(250,150,350,200),CPHUDBackgroundWindowMask);
if(_8){
_8.username=_b;
_8.delegate=_a;
objj_msgSend(_8,"setTitle:","User Settings");
objj_msgSend(_8,"setFloatingPanel:",YES);
var _c=objj_msgSend(_8,"contentView"),_d=objj_msgSend(_c,"bounds");
titleLabel=objj_msgSend(CPTextField,"labelWithTitle:","Change password for "+username);
objj_msgSend(titleLabel,"sizeToFit");
objj_msgSend(titleLabel,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(titleLabel,"setFrameOrigin:",CGPointMake(15,10));
objj_msgSend(_c,"addSubview:",titleLabel);
var _e=objj_msgSend(CPTextField,"labelWithTitle:","Old Password:");
objj_msgSend(_e,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_e,"setFrameOrigin:",CGPointMake(55,40));
objj_msgSend(_c,"addSubview:",_e);
oldPasswordField=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","",160);
objj_msgSend(oldPasswordField,"setFrameOrigin:",CGPointMake(140,35));
objj_msgSend(oldPasswordField,"setSecure:",YES);
objj_msgSend(_c,"addSubview:",oldPasswordField);
var _f=objj_msgSend(CPTextField,"labelWithTitle:","New Password:");
objj_msgSend(_f,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_f,"setFrameOrigin:",CGPointMake(48,70));
objj_msgSend(_c,"addSubview:",_f);
passwordField=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","",160);
objj_msgSend(passwordField,"setFrameOrigin:",CGPointMake(140,65));
objj_msgSend(passwordField,"setSecure:",YES);
objj_msgSend(_c,"addSubview:",passwordField);
var _10=objj_msgSend(CPTextField,"labelWithTitle:","Retype Password:");
objj_msgSend(_10,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_10,"setFrameOrigin:",CGPointMake(35,100));
objj_msgSend(_c,"addSubview:",_10);
passwordField2=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","",160);
objj_msgSend(passwordField2,"setFrameOrigin:",CGPointMake(140,95));
objj_msgSend(passwordField2,"setSecure:",YES);
objj_msgSend(_c,"addSubview:",passwordField2);
errorLabel=objj_msgSend(CPTextField,"labelWithTitle:","");
objj_msgSend(errorLabel,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(errorLabel,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(errorLabel,"setFrame:",CGRectMake(15,130,300,20));
objj_msgSend(_c,"addSubview:",errorLabel);
var _11=objj_msgSend(CPButton,"buttonWithTitle:theme:","Logout",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_11,"setFrame:",CGRectMake(30,165,70,20));
objj_msgSend(_c,"addSubview:",_11);
objj_msgSend(_11,"setTag:","logout");
objj_msgSend(_11,"setTarget:",_8);
objj_msgSend(_11,"setAction:",sel_getUid("buttonAction:"));
var _12=objj_msgSend(CPButton,"buttonWithTitle:theme:","Change",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_12,"setFrame:",CGRectMake(250,165,70,20));
objj_msgSend(_c,"addSubview:",_12);
objj_msgSend(_12,"setTag:","changepassword");
objj_msgSend(_12,"setTarget:",_8);
objj_msgSend(_12,"setAction:",sel_getUid("buttonAction:"));
var _13=objj_msgSend(CPButton,"buttonWithTitle:theme:","Close",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_13,"setFrame:",CGRectMake(170,165,70,20));
objj_msgSend(_c,"addSubview:",_13);
objj_msgSend(_13,"setTag:","close");
objj_msgSend(_13,"setTarget:",_8);
objj_msgSend(_13,"setAction:",sel_getUid("buttonAction:"));
aConnection=objj_msgSend(objj_msgSend(AgendiumConnection,"alloc"),"init");
}
return _8;
}
}),new objj_method(sel_getUid("validateFields"),function(_14,_15){
with(_14){
if(objj_msgSend(oldPasswordField,"objectValue").length===0){
objj_msgSend(errorLabel,"setObjectValue:","Please specify your old password.");
return NO;
}
if(objj_msgSend(passwordField,"objectValue").length===0){
objj_msgSend(errorLabel,"setObjectValue:","Please specify your new password.");
return NO;
}
if(objj_msgSend(passwordField,"objectValue")!=objj_msgSend(passwordField2,"objectValue")){
objj_msgSend(errorLabel,"setObjectValue:","Your new passwords don't match.");
return NO;
}
return YES;
}
}),new objj_method(sel_getUid("buttonAction:"),function(_16,_17,_18){
with(_16){
var tag=objj_msgSend(_18,"tag");
objj_msgSend(errorLabel,"setObjectValue:","");
switch(tag){
case "changepassword":
if(objj_msgSend(_16,"validateFields")){
objj_msgSend(aConnection,"changePassword:toPassword:forUser:delegate:",objj_msgSend(oldPasswordField,"objectValue"),objj_msgSend(passwordField,"objectValue"),_16.username,_16);
}
break;
case "close":
objj_msgSend(_16,"close");
break;
case "logout":
history.go(-1);
objj_msgSend(_16,"close");
break;
}
}
}),new objj_method(sel_getUid("didChangePassword"),function(_19,_1a){
with(_19){
objj_msgSend(errorLabel,"setObjectValue:","Password changed.");
objj_msgSend(passwordField,"setObjectValue:","");
objj_msgSend(passwordField2,"setObjectValue:","");
objj_msgSend(oldPasswordField,"setObjectValue:","");
}
}),new objj_method(sel_getUid("didntChangePassword"),function(_1b,_1c){
with(_1b){
objj_msgSend(errorLabel,"setObjectValue:","Couldn't change password!");
}
})]);
p;30;Panels/DatePicker/DatePicker.jt;39991;@STATIC;1.0;I;18;AppKit/CPControl.ji;9;Stepper.jt;39935;
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
p;27;Panels/DatePicker/Stepper.jt;4655;@STATIC;1.0;I;18;AppKit/CPControl.jI;17;AppKit/CPButton.jt;4591;
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
p;24;Table/ButtonColumnView.jt;2673;@STATIC;1.0;I;15;AppKit/CPView.jt;2634;
objj_executeFile("AppKit/CPView.j",NO);
var _1=objj_allocateClassPair(CPView,"ButtonColumnView"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("button"),new objj_ivar("row"),new objj_ivar("column"),new objj_ivar("normalTitle"),new objj_ivar("editingTitle")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:andTitle:andEditingTitle:"),function(_3,_4,_5,_6,_7){
with(_3){
_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("ButtonColumnView").super_class},"initWithFrame:",_5);
_3.editingTitle=_7;
_3.normalTitle=_6;
button=objj_msgSend(CPButton,"buttonWithTitle:",_6);
objj_msgSend(button,"setFrame:",CGRectMake(0,0,24,24));
objj_msgSend(button,"setCenter:",CPPointMake(12,25));
objj_msgSend(button,"setAction:",sel_getUid("rowSelected:"));
objj_msgSend(button,"setTarget:",_3);
objj_msgSend(_3,"addSubview:",button);
return _3;
}
}),new objj_method(sel_getUid("setObjectValue:"),function(_8,_9,_a){
with(_8){
column=_a.column;
if(_a.editing){
row=_a.row;
objj_msgSend(button,"setTitle:",_8.editingTitle);
objj_msgSend(button,"setFrame:",CGRectMake(0,0,24,24));
objj_msgSend(button,"setCenter:",CPPointMake(12,25));
}else{
if(_a.visible){
row=_a.row;
objj_msgSend(button,"setTitle:",_8.normalTitle);
objj_msgSend(button,"setFrame:",CGRectMake(0,0,24,24));
objj_msgSend(button,"setCenter:",CPPointMake(12,25));
}else{
row=-1;
objj_msgSend(button,"setFrame:",CGRectMakeZero());
}
}
}
}),new objj_method(sel_getUid("initWithCoder:"),function(_b,_c,_d){
with(_b){
_b=objj_msgSendSuper({receiver:_b,super_class:objj_getClass("ButtonColumnView").super_class},"initWithCoder:",_d);
button=objj_msgSend(_d,"decodeObjectForKey:","button");
normalTitle=objj_msgSend(_d,"decodeObjectForKey:","normalTitle");
editingTitle=objj_msgSend(_d,"decodeObjectForKey:","editingTitle");
return _b;
}
}),new objj_method(sel_getUid("encodeWithCoder:"),function(_e,_f,_10){
with(_e){
objj_msgSendSuper({receiver:_e,super_class:objj_getClass("ButtonColumnView").super_class},"encodeWithCoder:",_10);
objj_msgSend(_10,"encodeObject:forKey:",button,"button");
objj_msgSend(_10,"encodeObject:forKey:",normalTitle,"normalTitle");
objj_msgSend(_10,"encodeObject:forKey:",editingTitle,"editingTitle");
}
}),new objj_method(sel_getUid("rowSelected:"),function(_11,_12,_13){
with(_11){
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"postNotificationName:object:","RowClickedNotification",JSON.stringify({row:row,column:column}));
}
}),new objj_method(sel_getUid("setAction:"),function(_14,_15,_16){
with(_14){
}
}),new objj_method(sel_getUid("setTarget:"),function(_17,_18,_19){
with(_17){
}
})]);
p;27;Table/ImageTextColumnView.jt;2137;@STATIC;1.0;I;15;AppKit/CPView.jt;2098;
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
if(_8=="Group"){
_9="Resources/group2.png";
}else{
if(_8=="Text"){
_9="Resources/text2.png";
}else{
_9="Resources/detail2.png";
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
p;27;Table/TextFieldColumnView.jt;1171;@STATIC;1.0;I;15;AppKit/CPView.jt;1132;
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
p;19;Table/TMTableView.jt;2858;@STATIC;1.0;I;21;Foundation/CPObject.ji;18;ButtonColumnView.ji;21;ImageTextColumnView.jt;2764;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("ButtonColumnView.j",YES);
objj_executeFile("ImageTextColumnView.j",YES);
var _1=objj_allocateClassPair(CPTableView,"TMTableView"),_2=_1.isa;
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("initWithFrame:"),function(_3,_4,_5){
with(_3){
if(_3=objj_msgSendSuper({receiver:_3,super_class:objj_getClass("TMTableView").super_class},"initWithFrame:",_5)){
objj_msgSend(_3,"setUsesAlternatingRowBackgroundColors:",YES);
objj_msgSend(_3,"setAlternatingRowBackgroundColors:",[objj_msgSend(CPColor,"whiteColor"),objj_msgSend(CPColor,"colorWithHexString:","e4e7ff")]);
objj_msgSend(_3,"setRowHeight:",50);
objj_msgSend(_3,"setAllowsColumnSelection:",NO);
var _6=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","zero");
var _7=objj_msgSend(objj_msgSend(ImageTextColumnView,"alloc"),"initWithFrame:",CGRectMake(0,0,20,30));
objj_msgSend(_6,"setDataView:",_7);
objj_msgSend(objj_msgSend(_6,"headerView"),"setStringValue:","");
objj_msgSend(_6,"setWidth:",75);
objj_msgSend(_6,"setEditable:",NO);
objj_msgSend(_3,"addTableColumn:",_6);
var _8=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","first");
objj_msgSend(objj_msgSend(_8,"headerView"),"setStringValue:","Title");
var _9=objj_msgSend(CPTextField,"labelWithTitle:","");
objj_msgSend(_9,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(_9,"setVerticalAlignment:",CPCenterTextAlignment);
objj_msgSend(_9,"setLineBreakMode:",CPLineBreakByWordWrapping);
objj_msgSend(_8,"setDataView:",_9);
objj_msgSend(_8,"setWidth:",170);
objj_msgSend(_8,"setEditable:",YES);
objj_msgSend(_3,"addTableColumn:",_8);
var _a=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","second");
objj_msgSend(objj_msgSend(_a,"headerView"),"setStringValue:","Subtitle");
objj_msgSend(_a,"setWidth:",230);
objj_msgSend(_a,"setEditable:",YES);
objj_msgSend(_a,"setDataView:",_9);
objj_msgSend(_3,"addTableColumn:",_a);
var _b=objj_msgSend(objj_msgSend(ButtonColumnView,"alloc"),"initWithFrame:andTitle:andEditingTitle:",CGRectMake(0,0,10,20),"▶","−");
var _c=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","button1");
objj_msgSend(_c,"setDataView:",_b);
objj_msgSend(_c,"setWidth:",30);
objj_msgSend(_c,"setEditable:",YES);
objj_msgSend(_3,"addTableColumn:",_c);
var _d=objj_msgSend(objj_msgSend(ButtonColumnView,"alloc"),"initWithFrame:andTitle:andEditingTitle:",CGRectMake(0,0,10,20),"","⏎");
var _e=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","button2");
objj_msgSend(_e,"setDataView:",_d);
objj_msgSend(_e,"setWidth:",30);
objj_msgSend(_e,"setEditable:",YES);
objj_msgSend(_3,"addTableColumn:",_e);
}
return _3;
}
})]);
p;22;Test/NewTemplateTest.jt;2109;@STATIC;1.0;I;21;Foundation/CPObject.ji;16;../NewTemplate.jt;2043;
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
var _7=new Date(2010,9-1,5);
var _8=new Date(2010,7-1,1);
var _9=objj_msgSend(NewTemplate,"dataonedayonetrack:withFirstDate:",_8,_7);
objj_msgSend(_5,"assertNotNull:",_9);
var _a=JSON.parse(_9);
objj_msgSend(_5,"assert:notSame:",_9,undefined);
objj_msgSend(_5,"assert:notSame:",_a.rootpage,undefined);
objj_msgSend(_5,"assert:same:",_a.rootpage.type,"Navigation");
objj_msgSend(_5,"assert:equals:",_a.rootpage.children[0].subtitle,"Update: 01. Jul.");
objj_msgSend(_5,"assert:equals:",_a.rootpage.children[2].type,"Navigation");
objj_msgSend(_5,"assert:equals:",_a.rootpage.children[2].title,"Sessions");
objj_msgSend(_5,"assert:equals:",_a.rootpage.children[2].subtitle,"Sun, 05 Sep 2010");
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
objj_msgSend(_b,"assert:equals:",obj.rootpage.children[0].subtitle,"Update: 01. Jul.");
objj_msgSend(_b,"assert:equals:",obj.rootpage.children[2].type,"Navigation");
objj_msgSend(_b,"assert:equals:",obj.rootpage.children[2].title,"Day 01");
objj_msgSend(_b,"assert:equals:",obj.rootpage.children[2].subtitle,"Thu, 30 Sep 2010");
objj_msgSend(_b,"assert:equals:",obj.rootpage.children[3].subtitle,"Fri, 01 Oct 2010");
objj_msgSend(_b,"assert:equals:",obj.rootpage.children[4].subtitle,"Sat, 02 Oct 2010");
}
})]);
p;15;Test/PageTest.jt;3533;@STATIC;1.0;I;21;Foundation/CPObject.ji;9;../Page.jt;3475;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("../Page.j",YES);
var _1=objj_allocateClassPair(OJTestCase,"PageTest"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("page"),new objj_ivar("child1")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("setUp"),function(_3,_4){
with(_3){
page=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andLogourl:andNavigationId:","A Title","A Subtitle","pagetype","","anavid");
child1=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andLogourl:andNavigationId:","A ChildTitle","A ChildSubtitle","childpagetype","","anavid2");
child1.attributes[0]={key:"A key",value:"A value"};
}
}),new objj_method(sel_getUid("testThatInitializationWorks"),function(_5,_6){
with(_5){
objj_msgSend(_5,"assertNotNull:",page);
objj_msgSend(_5,"assert:equals:",page.title,"A Title");
objj_msgSend(_5,"assert:equals:",page.subtitle,"A Subtitle");
objj_msgSend(_5,"assert:equals:",page.type,"pagetype");
objj_msgSend(_5,"assert:equals:",page.navigationId,"anavid");
}
}),new objj_method(sel_getUid("testIsEqual"),function(_7,_8){
with(_7){
objj_msgSend(_7,"assert:equals:",page,page);
var o=objj_msgSend(objj_msgSend(CPObject,"alloc"),"init");
objj_msgSend(_7,"assertFalse:",objj_msgSend(page,"isEqual:",o));
objj_msgSend(_7,"assertFalse:",objj_msgSend(page,"isEqual:",child1));
var _9=objj_msgSend(page,"deepCopy");
objj_msgSend(_7,"assert:equals:",page,_9);
_9.subtitle="asdas";
objj_msgSend(_7,"assertFalse:",objj_msgSend(page,"isEqual:",_9));
}
}),new objj_method(sel_getUid("testDeepCopy"),function(_a,_b){
with(_a){
objj_msgSend(page,"addChild:atIndex:",child1,0);
var _c=objj_msgSend(page,"deepCopy");
objj_msgSend(_a,"assert:equals:",page.type,_c.type);
objj_msgSend(_a,"assert:equals:",page.title,_c.title);
objj_msgSend(_a,"assert:equals:",page.subtitle,_c.subtitle);
objj_msgSend(_a,"assert:equals:",page.children.length,_c.children.length);
objj_msgSend(_a,"assert:equals:",page.children[0].type,_c.children[0].type);
objj_msgSend(_a,"assert:equals:",page.children[0].title,_c.children[0].title);
objj_msgSend(_a,"assert:equals:",page.children[0].subtitle,_c.children[0].subtitle);
objj_msgSend(_a,"assert:equals:",page.children[0].attributes.length,_c.children[0].attributes.length);
objj_msgSend(_a,"assert:equals:",_c.children[0].attributes[0].key,"A key");
objj_msgSend(_a,"assert:equals:",_c.children[0].attributes[0].value,"A value");
}
}),new objj_method(sel_getUid("testRootPage"),function(_d,_e){
with(_d){
objj_msgSend(_d,"assertTrue:",objj_msgSend(page,"isRootPage"));
objj_msgSend(page,"addChild:atIndex:",child1,0);
objj_msgSend(_d,"assertTrue:",objj_msgSend(page,"isRootPage"));
objj_msgSend(_d,"assertFalse:",objj_msgSend(child1,"isRootPage"));
}
}),new objj_method(sel_getUid("testChildren"),function(_f,_10){
with(_f){
objj_msgSend(_f,"assert:equals:",page.children.length,0);
objj_msgSend(page,"addChild:atIndex:",child1,0);
objj_msgSend(_f,"assert:equals:",page.children.length,1);
objj_msgSend(page,"addChild:atIndex:",child1,1);
objj_msgSend(_f,"assert:equals:",page.children.length,2);
objj_msgSend(page,"removeChild:",1);
objj_msgSend(_f,"assert:equals:",page.children.length,1);
objj_msgSend(page,"removeChild:",0);
objj_msgSend(_f,"assert:equals:",page.children.length,0);
objj_msgSend(page,"addChild:atIndex:",child1,0);
objj_msgSend(page,"duplicateChild:",0);
objj_msgSend(_f,"assert:equals:",page.children.length,2);
}
})]);
e;