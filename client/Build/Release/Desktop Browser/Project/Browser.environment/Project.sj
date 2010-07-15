@STATIC;1.0;p;15;AppController.jt;5356;@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;10;PageView.ji;20;PageViewController.jt;5261;
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
p;6;main.jt;267;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jt;181;
objj_executeFile("Foundation/Foundation.j",NO);
objj_executeFile("AppKit/AppKit.j",NO);
objj_executeFile("AppController.j",YES);
main=function(_1,_2){
CPApplicationMain(_1,_2);
};
p;6;Page.jt;2511;@STATIC;1.0;I;21;Foundation/CPObject.jt;2466;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"Page"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("title"),new objj_ivar("subtitle"),new objj_ivar("children"),new objj_ivar("ancestor")]);
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
}),new objj_method(sel_getUid("init"),function(_17,_18){
with(_17){
_17=objj_msgSendSuper({receiver:_17,super_class:objj_getClass("Page").super_class},"init");
children=objj_msgSend(objj_msgSend(CPArray,"alloc"),"init");
return _17;
}
}),new objj_method(sel_getUid("initWithTitle:andSubtitle:"),function(_19,_1a,_1b,_1c){
with(_19){
_19=objj_msgSend(_19,"init");
title=_1b;
subtitle=_1c;
return _19;
}
}),new objj_method(sel_getUid("addChild:"),function(_1d,_1e,_1f){
with(_1d){
objj_msgSend(_1f,"setAncestor:",_1d);
objj_msgSend(children,"addObject:",_1f);
}
}),new objj_method(sel_getUid("removeChild:"),function(_20,_21,_22){
with(_20){
objj_msgSend(children,"removeObjectAtIndex:",_22);
}
}),new objj_method(sel_getUid("toJSON"),function(_23,_24){
with(_23){
var _25="";
for(var i=0;i<children.length;i++){
_25+=objj_msgSend(children[i],"toJSON");
_25+=",";
}
if(_25.length>0){
_25=_25.substring(0,_25.length-1);
}
return "{\"title\":\""+title+"\",\"subtitle\":\""+subtitle+"\",\"children\":["+_25+"]}";
}
}),new objj_method(sel_getUid("description"),function(_26,_27){
with(_26){
return title;
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("initFromJSONObject:"),function(_28,_29,_2a){
with(_28){
var _2b=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:",_2a.title,_2a.subtitle);
for(var i=0;i<_2a.children.length;i++){
var _2c=objj_msgSend(Page,"initFromJSONObject:",_2a.children[i]);
objj_msgSend(_2b,"addChild:",_2c);
}
return _2b;
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
p;20;PageViewController.jt;6091;@STATIC;1.0;I;21;Foundation/CPObject.ji;18;ButtonColumnView.jt;6023;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("ButtonColumnView.j",YES);
var _1=objj_allocateClassPair(CPViewController,"PageViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("scrollView"),new objj_ivar("page"),new objj_ivar("deleteButton"),new objj_ivar("backButton"),new objj_ivar("editButton"),new objj_ivar("table"),new objj_ivar("titleField"),new objj_ivar("editing")]);
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
table=objj_msgSend(objj_msgSend(CPTableView,"alloc"),"initWithFrame:",CGRectMake(0,0,200,500));
var _13=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","title");
objj_msgSend(objj_msgSend(_13,"headerView"),"setStringValue:","Title");
objj_msgSend(_13,"setWidth:",200);
objj_msgSend(_13,"setEditable:",YES);
objj_msgSend(table,"addTableColumn:",_13);
var _14=objj_msgSend(objj_msgSend(CPTableColumn,"alloc"),"initWithIdentifier:","subtitle");
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
objj_msgSend(table,"setAllowsColumnSelection:",YES);
objj_msgSend(scrollView,"setDocumentView:",table);
objj_msgSend(deleteButton,"setEnabled:",NO);
objj_msgSend(backButton,"setEnabled:",NO);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_11,sel_getUid("tableViewSelectionDidChange:"),CPTableViewSelectionDidChangeNotification,nil);
objj_msgSend(objj_msgSend(CPNotificationCenter,"defaultCenter"),"addObserver:selector:name:object:",_11,sel_getUid("rowClicked:"),"RowClickedNotification",nil);
}
}),new objj_method(sel_getUid("tableView:shouldEditTableColumn:row:"),function(_17,_18,_19,_1a,row){
with(_17){
objj_msgSend(_17,"toggleEditing:",_19);
return _17.editing;
}
}),new objj_method(sel_getUid("toggleEditing:"),function(_1b,_1c,_1d){
with(_1b){
var _1e;
if(_1b.editing){
_1e=objj_msgSend(CPTextField,"labelWithTitle:","");
objj_msgSend(_1b,"setEditing:",NO);
objj_msgSend(editButton,"setTitle:","Edit");
}else{
_1e=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","",100);
objj_msgSend(_1b,"setEditing:",YES);
objj_msgSend(editButton,"setTitle:","Done");
}
var _1f=objj_msgSend(table,"tableColumns");
objj_msgSend(_1f[0],"setDataView:",_1e);
objj_msgSend(_1f[1],"setDataView:",_1e);
objj_msgSend(_1b,"myRefresh");
}
}),new objj_method(sel_getUid("numberOfRowsInTableView:"),function(_20,_21,_22){
with(_20){
return objj_msgSend(objj_msgSend(page,"children"),"count");
}
}),new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"),function(_23,_24,_25,_26,row){
with(_23){
var _27=objj_msgSend(objj_msgSend(page,"children"),"objectAtIndex:",row);
if(objj_msgSend(objj_msgSend(_26,"identifier"),"isEqual:","title")){
return objj_msgSend(_27,"title");
}else{
if(objj_msgSend(objj_msgSend(_26,"identifier"),"isEqual:","subtitle")){
return objj_msgSend(_27,"subtitle");
}else{
return row+"";
}
}
}
}),new objj_method(sel_getUid("tableView:setObjectValue:forTableColumn:row:"),function(_28,_29,_2a,_2b,_2c,row){
with(_28){
var _2d=objj_msgSend(objj_msgSend(page,"children"),"objectAtIndex:",row);
if(objj_msgSend(objj_msgSend(_2c,"identifier"),"isEqual:","title")){
objj_msgSend(_2d,"setTitle:",_2b);
}else{
objj_msgSend(_2d,"setSubtitle:",_2b);
}
}
}),new objj_method(sel_getUid("tableViewSelectionDidChange:"),function(_2e,_2f,_30){
with(_2e){
var _31=objj_msgSend(objj_msgSend(table,"selectedRowIndexes"),"firstIndex");
objj_msgSend(deleteButton,"setEnabled:",_31>-1);
}
}),new objj_method(sel_getUid("addItemToList:"),function(_32,_33,_34){
with(_32){
var _35=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:","A title","A subtitle");
objj_msgSend(page,"addChild:",_35);
objj_msgSend(table,"reloadData");
}
}),new objj_method(sel_getUid("deleteItemFromList:"),function(_36,_37,_38){
with(_36){
objj_msgSend(page,"removeChild:",objj_msgSend(table,"selectedRow"));
objj_msgSend(table,"deselectAll");
objj_msgSend(table,"reloadData");
objj_msgSend(_36,"tableViewSelectionDidChange:",null);
}
}),new objj_method(sel_getUid("rowClicked:"),function(_39,_3a,_3b){
with(_39){
var row=objj_msgSend(_3b,"object");
page=objj_msgSend(objj_msgSend(page,"children"),"objectAtIndex:",row);
objj_msgSend(_39,"myRefresh");
}
}),new objj_method(sel_getUid("backButtonClicked:"),function(_3c,_3d,_3e){
with(_3c){
page=objj_msgSend(page,"ancestor");
objj_msgSend(_3c,"myRefresh");
}
}),new objj_method(sel_getUid("myRefresh"),function(_3f,_40){
with(_3f){
objj_msgSend(table,"reloadData");
objj_msgSend(backButton,"setEnabled:",page.ancestor!=null);
objj_msgSend(table,"deselectAll");
var _41=page.title;
if(page.subtitle!=null){
_41+=" ("+page.subtitle+")";
}
objj_msgSend(titleField,"setObjectValue:",_41);
}
})]);
e;