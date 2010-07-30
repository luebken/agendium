@STATIC;1.0;I;15;AppKit/CPView.jt;2187;
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
