@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.jt;2920;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("AppKit/CPPanel.j",NO);
var _1=objj_allocateClassPair(CPPanel,"LoginPanel"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("delegate")]);
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
_8=objj_msgSend(_8,"initWithContentRect:styleMask:",CGRectMake(100,100,350,150),CPHUDBackgroundWindowMask);
if(_8){
_8.delegate=_a;
objj_msgSend(_8,"setTitle:","Login");
objj_msgSend(_8,"setFloatingPanel:",YES);
var _b=objj_msgSend(_8,"contentView"),_c=objj_msgSend(_b,"bounds");
var _d=objj_msgSend(CPTextField,"labelWithTitle:","Enter your email and password to login.");
objj_msgSend(_d,"setFont:",objj_msgSend(CPFont,"systemFontOfSize:",14));
objj_msgSend(_d,"sizeToFit");
objj_msgSend(_d,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_d,"setFrameOrigin:",CGPointMake(45,5));
objj_msgSend(_b,"addSubview:",_d);
var _e=objj_msgSend(CPTextField,"labelWithTitle:","Email:");
objj_msgSend(_e,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_e,"setFrameOrigin:",CGPointMake(62,40));
objj_msgSend(_b,"addSubview:",_e);
var _f=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","",200);
objj_msgSend(_f,"setFrameOrigin:",CGPointMake(100,35));
objj_msgSend(_b,"addSubview:",_f);
var _10=objj_msgSend(CPTextField,"labelWithTitle:","Password:");
objj_msgSend(_10,"setTextColor:",objj_msgSend(CPColor,"whiteColor"));
objj_msgSend(_10,"setFrameOrigin:",CGPointMake(40,70));
objj_msgSend(_b,"addSubview:",_10);
var _11=objj_msgSend(CPTextField,"textFieldWithStringValue:placeholder:width:","","",200);
objj_msgSend(_11,"setFrameOrigin:",CGPointMake(100,65));
objj_msgSend(_11,"setSecure:",YES);
objj_msgSend(_b,"addSubview:",_11);
var _12=objj_msgSend(CPButton,"buttonWithTitle:theme:","Login",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_12,"setFrame:",CGRectMake(250,120,70,20));
objj_msgSend(_b,"addSubview:",_12);
objj_msgSend(_12,"setTag:",1);
objj_msgSend(_12,"setTarget:",_8);
objj_msgSend(_12,"setAction:",sel_getUid("buttonAction:"));
var _13=objj_msgSend(CPButton,"buttonWithTitle:theme:","Cancel",objj_msgSend(CPTheme,"themeNamed:","Aristo-HUD"));
objj_msgSend(_13,"setFrame:",CGRectMake(170,120,70,20));
objj_msgSend(_b,"addSubview:",_13);
objj_msgSend(_13,"setTag:",0);
objj_msgSend(_13,"setTarget:",_8);
objj_msgSend(_13,"setAction:",sel_getUid("buttonAction:"));
}
return _8;
}
}),new objj_method(sel_getUid("buttonAction:"),function(_14,_15,_16){
with(_14){
if(objj_msgSend(delegate,"respondsToSelector:",sel_getUid("panelDidClose:"))){
objj_msgSend(delegate,"panelDidClose:",objj_msgSend(_16,"tag"));
}
objj_msgSend(_14,"close");
}
})]);
