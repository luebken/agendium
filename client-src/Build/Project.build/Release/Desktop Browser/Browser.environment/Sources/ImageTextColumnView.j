@STATIC;1.0;I;15;AppKit/CPView.jt;2099;
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
