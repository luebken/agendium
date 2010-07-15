@STATIC;1.0;I;21;Foundation/CPObject.ji;18;ButtonColumnView.jt;6023;
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
