@STATIC;1.0;I;21;Foundation/CPObject.ji;18;ButtonColumnView.ji;21;CPPropertyAnimation.jt;9150;
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
