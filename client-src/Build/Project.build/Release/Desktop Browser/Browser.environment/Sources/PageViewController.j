@STATIC;1.0;I;21;Foundation/CPObject.ji;18;ButtonColumnView.ji;21;CPPropertyAnimation.ji;21;ImageTextColumnView.jt;10234;
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
if(_3e=="Navigationpage"){
_3f=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:","The title of a subpage","The optional subtitle of a subpage","Navigation");
}else{
if(_3e=="Detailpage"){
_3f=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:","The title of a subpage","The optional subtitle of a subpage","Detail");
}else{
_3f=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:","A group title","","Spacer");
}
}
objj_msgSend(page,"addChild:atIndex:",_3f,objj_msgSend(table,"selectedRow"));
}else{
var _40={key:"A key",value:"A value"};
objj_msgSend(objj_msgSend(page,"attributes"),"insertObject:atIndex:",_40,objj_msgSend(table,"selectedRow"));
}
objj_msgSend(table,"reloadData");
}
}),new objj_method(sel_getUid("deleteItemFromList:"),function(_41,_42,row){
with(_41){
if(objj_msgSend(page,"isNavigationType")){
objj_msgSend(page,"removeChild:",row);
}else{
objj_msgSend(objj_msgSend(page,"attributes"),"removeObjectAtIndex:",row);
}
objj_msgSend(table,"deselectAll");
objj_msgSend(table,"reloadData");
}
}),new objj_method(sel_getUid("rowClicked:"),function(_43,_44,_45){
with(_43){
if(!objj_msgSend(_43,"editing")){
var row=objj_msgSend(_45,"object");
page=objj_msgSend(objj_msgSend(page,"children"),"objectAtIndex:",row);
objj_msgSend(objj_msgSend(CPPropertyAnimation,"slideLeft:view:",_43,scrollView),"startAnimation");
objj_msgSend(delegate,"selectedPage:reverse:",page,NO);
objj_msgSend(_43,"myRefresh");
}else{
objj_msgSend(_43,"deleteItemFromList:",objj_msgSend(_45,"object"));
}
}
}),new objj_method(sel_getUid("animationDidEnd:"),function(_46,_47,_48){
with(_46){
console.log("animationDidEnd");
}
}),new objj_method(sel_getUid("backButtonClicked:"),function(_49,_4a,_4b){
with(_49){
objj_msgSend(objj_msgSend(CPPropertyAnimation,"slideRight:view:",_49,scrollView),"startAnimation");
page=objj_msgSend(page,"ancestor");
objj_msgSend(delegate,"selectedPage:reverse:",page,YES);
objj_msgSend(_49,"myRefresh");
}
}),new objj_method(sel_getUid("myRefresh"),function(_4c,_4d){
with(_4c){
objj_msgSend(table,"reloadData");
objj_msgSend(backButton,"setEnabled:",page.ancestor!=null);
objj_msgSend(table,"deselectAll");
var _4e=page.title;
if(page.subtitle!=null){
_4e+=" / "+page.subtitle;
}
if(page.title){
_4e+=" ("+page.type+")";
}
objj_msgSend(titleField,"setObjectValue:",_4e);
objj_msgSend(itemtypeButton,"removeAllItems");
var _4f=objj_msgSend(objj_msgSend(table,"tableColumns")[0],"headerView");
var _50=objj_msgSend(objj_msgSend(table,"tableColumns")[1],"headerView");
var _51=objj_msgSend(objj_msgSend(table,"tableColumns")[2],"headerView");
objj_msgSend(_4f,"setStringValue:","Type");
if(objj_msgSend(page,"isNavigationType")){
objj_msgSend(_50,"setStringValue:","Title");
objj_msgSend(_51,"setStringValue:","Subtitle");
objj_msgSend(itemtypeButton,"addItemsWithTitles:",["Navigationpage","Detailpage","Spacer"]);
}else{
objj_msgSend(_50,"setStringValue:","Attribute");
objj_msgSend(_51,"setStringValue:","Value");
objj_msgSend(itemtypeButton,"addItemsWithTitles:",["Text","Link","Tweeter"]);
}
}
})]);
