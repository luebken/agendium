@STATIC;1.0;I;15;AppKit/CPView.jt;1132;
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
