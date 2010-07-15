@STATIC;1.0;I;21;Foundation/CPObject.jt;2466;
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
