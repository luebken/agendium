@STATIC;1.0;I;20;AppKit/CPAnimation.jt;5703;
objj_executeFile("AppKit/CPAnimation.j",NO);
var _1=objj_allocateClassPair(CPAnimation,"CPPropertyAnimation"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("view"),new objj_ivar("properties"),new objj_ivar("_startView"),new objj_ivar("_endView"),new objj_ivar("_startFrame"),new objj_ivar("_finalDelegate"),new objj_ivar("direction")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("direction"),function(_3,_4){
with(_3){
return direction;
}
}),new objj_method(sel_getUid("setDirection:"),function(_5,_6,_7){
with(_5){
direction=_7;
}
}),new objj_method(sel_getUid("initWithView:"),function(_8,_9,_a){
with(_8){
_8=objj_msgSendSuper({receiver:_8,super_class:objj_getClass("CPPropertyAnimation").super_class},"initWithDuration:animationCurve:",0.4,CPAnimationEaseOut);
if(_8){
view=_a;
_startFrame=CGRectMakeCopy(objj_msgSend(_a,"frame"));
properties=objj_msgSend(CPDictionary,"dictionary");
}
return _8;
}
}),new objj_method(sel_getUid("animationDidEnd:"),function(_b,_c,_d){
with(_b){
var _e;
if(_d.direction==="left"){
_e=CGRectMake(_startFrame.origin.x+_startFrame.size.width,_startFrame.origin.y,_startFrame.size.width,_startFrame.size.height);
}else{
_e=CGRectMake(_startFrame.origin.x-_startFrame.size.width,_startFrame.origin.y,_startFrame.size.width,_startFrame.size.height);
}
var _f=objj_msgSend(objj_msgSend(CPPropertyAnimation,"alloc"),"initWithView:",view);
objj_msgSend(_f,"setDelegate:",_finalDelegate);
objj_msgSend(_f,"addProperty:start:end:","frame",_e,_startFrame);
objj_msgSend(_f,"startAnimation");
}
}),new objj_method(sel_getUid("view"),function(_10,_11){
with(_10){
return view;
}
}),new objj_method(sel_getUid("addProperty:start:end:"),function(_12,_13,_14,_15,_16){
with(_12){
if(!objj_msgSend(view,"respondsToSelector:",_14)){
return;
}
objj_msgSend(properties,"setObject:forKey:",{start:_15,end:_16},_14);
objj_msgSend(view,"setValue:forKey:",_15,_14);
}
}),new objj_method(sel_getUid("addToViewOnStart:"),function(_17,_18,_19){
with(_17){
_startView=_19;
}
}),new objj_method(sel_getUid("willAddToViewOnStart"),function(_1a,_1b){
with(_1a){
return _startView;
}
}),new objj_method(sel_getUid("removeFromSuperviewOnEnd:"),function(_1c,_1d,_1e){
with(_1c){
_endView=_1e;
}
}),new objj_method(sel_getUid("willRemoveFromSuperviewOnEnd"),function(_1f,_20){
with(_1f){
return _endView;
}
}),new objj_method(sel_getUid("setCurrentProgress:"),function(_21,_22,_23){
with(_21){
objj_msgSendSuper({receiver:_21,super_class:objj_getClass("CPPropertyAnimation").super_class},"setCurrentProgress:",_23);
var _23=objj_msgSend(_21,"currentValue");
var _24=objj_msgSend(properties,"allKeys"),_25=objj_msgSend(_24,"count");
for(var i=0;i<_25;i++){
var _26=_24[i],_27=objj_msgSend(properties,"objectForKey:",_26);
if(!_27){
continue;
}
var _28=_27.start,end=_27.end,_29;
if(_26=="width"||_26=="height"){
_29=(_23*(end-_28))+_28;
}else{
if(_26=="size"){
_29=CGSizeMake((_23*(end.width-_28.width))+_28.width,(_23*(end.height-_28.height))+_28.height);
}else{
if(_26=="frame"){
_29=CGRectMake((_23*(end.origin.x-_28.origin.x))+_28.origin.x,(_23*(end.origin.y-_28.origin.y))+_28.origin.y,(_23*(end.size.width-_28.size.width))+_28.size.width,(_23*(end.size.height-_28.size.height))+_28.size.height);
}else{
if(_26=="alphaValue"){
_29=(_23*(end-_28))+_28;
}else{
if(_26=="backgroundColor"||_26=="textColor"||_26=="textShadowColor"){
var red=(_23*(objj_msgSend(end,"redComponent")-objj_msgSend(_28,"redComponent")))+objj_msgSend(_28,"redComponent"),_2a=(_23*(objj_msgSend(end,"greenComponent")-objj_msgSend(_28,"greenComponent")))+objj_msgSend(_28,"greenComponent"),_2b=(_23*(objj_msgSend(end,"blueComponent")-objj_msgSend(_28,"blueComponent")))+objj_msgSend(_28,"blueComponent"),_2c=(_23*(objj_msgSend(end,"alphaComponent")-objj_msgSend(_28,"alphaComponent")))+objj_msgSend(_28,"alphaComponent");
_29=objj_msgSend(CPColor,"colorWithCalibratedRed:green:blue:alpha:",red,_2a,_2b,_2c);
}
}
}
}
}
objj_msgSend(view,"setValue:forKey:",_29,_26);
}
}
}),new objj_method(sel_getUid("startAnimation"),function(_2d,_2e){
with(_2d){
var _2f=objj_msgSend(properties,"count");
for(var i=0;i<_2f;i++){
var _30=objj_msgSend(properties,"allKeys")[i],_31=objj_msgSend(properties,"objectForKey:",_30);
if(!_31){
continue;
}
objj_msgSend(view,"setValue:forKey:",_31.start,_30);
}
if(_startView){
objj_msgSend(_startView,"addSubview:",view);
}
objj_msgSendSuper({receiver:_2d,super_class:objj_getClass("CPPropertyAnimation").super_class},"startAnimation");
}
}),new objj_method(sel_getUid("animationTimerDidFire:"),function(_32,_33,_34){
with(_32){
objj_msgSendSuper({receiver:_32,super_class:objj_getClass("CPPropertyAnimation").super_class},"animationTimerDidFire:",_34);
if(_progress===1&&_endView){
objj_msgSend(view,"removeFromSuperview");
}
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("slideLeft:view:"),function(_35,_36,_37,_38){
with(_35){
var _39=objj_msgSend(_38,"frame");
var _3a=CGRectMake(_39.origin.x-_39.size.width,_39.origin.y,_39.size.width,_39.size.height);
var _3b=objj_msgSend(objj_msgSend(CPPropertyAnimation,"alloc"),"initWithView:",_38);
_3b.direction="left";
objj_msgSend(_3b,"setDelegate:",_3b);
objj_msgSend(_3b,"addProperty:start:end:","frame",_39,_3a);
_finalDelegate=_37;
return _3b;
}
}),new objj_method(sel_getUid("slideRight:view:"),function(_3c,_3d,_3e,_3f){
with(_3c){
var _40=objj_msgSend(_3f,"frame");
var _41=CGRectMake(_40.origin.x+_40.size.width,_40.origin.y,_40.size.width,_40.size.height);
var _42=objj_msgSend(objj_msgSend(CPPropertyAnimation,"alloc"),"initWithView:",_3f);
_42.direction="right";
objj_msgSend(_42,"setDelegate:",_42);
objj_msgSend(_42,"addProperty:start:end:","frame",_40,_41);
_finalDelegate=_3e;
return _42;
}
})]);
