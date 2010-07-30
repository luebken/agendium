@STATIC;1.0;I;21;Foundation/CPObject.jt;4035;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"Page"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("title"),new objj_ivar("subtitle"),new objj_ivar("children"),new objj_ivar("type"),new objj_ivar("attributes"),new objj_ivar("navigationId"),new objj_ivar("ancestor")]);
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
}),new objj_method(sel_getUid("type"),function(_12,_13){
with(_12){
return type;
}
}),new objj_method(sel_getUid("setType:"),function(_14,_15,_16){
with(_14){
type=_16;
}
}),new objj_method(sel_getUid("attributes"),function(_17,_18){
with(_17){
return attributes;
}
}),new objj_method(sel_getUid("setAttributes:"),function(_19,_1a,_1b){
with(_19){
attributes=_1b;
}
}),new objj_method(sel_getUid("navigationId"),function(_1c,_1d){
with(_1c){
return navigationId;
}
}),new objj_method(sel_getUid("setNavigationId:"),function(_1e,_1f,_20){
with(_1e){
navigationId=_20;
}
}),new objj_method(sel_getUid("ancestor"),function(_21,_22){
with(_21){
return ancestor;
}
}),new objj_method(sel_getUid("setAncestor:"),function(_23,_24,_25){
with(_23){
ancestor=_25;
}
}),new objj_method(sel_getUid("init"),function(_26,_27){
with(_26){
_26=objj_msgSendSuper({receiver:_26,super_class:objj_getClass("Page").super_class},"init");
children=objj_msgSend(objj_msgSend(CPArray,"alloc"),"init");
attributes=objj_msgSend(objj_msgSend(CPArray,"alloc"),"init");
type="Navigation";
navigationId="";
return _26;
}
}),new objj_method(sel_getUid("initWithTitle:andSubtitle:andType:andNavigationId:"),function(_28,_29,_2a,_2b,_2c,_2d){
with(_28){
_28=objj_msgSend(_28,"init");
title=_2a;
subtitle=_2b;
type=_2c;
navigationId=_2d;
return _28;
}
}),new objj_method(sel_getUid("addChild:atIndex:"),function(_2e,_2f,_30,_31){
with(_2e){
objj_msgSend(_30,"setAncestor:",_2e);
if(_31<0){
_31=children.length;
}
objj_msgSend(children,"insertObject:atIndex:",_30,_31);
}
}),new objj_method(sel_getUid("removeChild:"),function(_32,_33,_34){
with(_32){
objj_msgSend(children,"removeObjectAtIndex:",_34);
}
}),new objj_method(sel_getUid("toJSON"),function(_35,_36){
with(_35){
var _37="";
for(var i=0;i<children.length;i++){
_37+=objj_msgSend(children[i],"toJSON");
_37+=",";
}
if(_37.length>0){
_37=_37.substring(0,_37.length-1);
}
var _38="";
for(var i=0;i<attributes.length;i++){
_38+="{\"key\":\""+attributes[i].key+"\"";
_38+=",\"value\":\""+attributes[i].value+"\"}";
_38+=",";
}
if(_38.length>0){
_38=_38.substring(0,_38.length-1);
}
var _39="{\"title\":\""+title;
if(subtitle){
_39+="\",\"subtitle\":\""+subtitle;
}
_39+="\",\"type\":\""+type+"\",\"children\":["+_37+"],\"attributes\":["+_38+"]}";
return _39;
}
}),new objj_method(sel_getUid("description"),function(_3a,_3b){
with(_3a){
return title;
}
}),new objj_method(sel_getUid("isNavigationType"),function(_3c,_3d){
with(_3c){
return type==="Navigation";
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("initFromJSONObject:andNavigationId:"),function(_3e,_3f,_40,_41){
with(_3e){
var _42=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:andNavigationId:",_40.title,_40.subtitle,_40.type,_41);
for(var i=0;i<_40.children.length;i++){
var _43=_41+"c"+i;
var _44=objj_msgSend(Page,"initFromJSONObject:andNavigationId:",_40.children[i],_43);
objj_msgSend(_42,"addChild:atIndex:",_44,-1);
}
if(_40.attributes){
for(var i=0;i<_40.attributes.length;i++){
var _45=_40.attributes[i];
console.log(_45);
objj_msgSend(objj_msgSend(_42,"attributes"),"insertObject:atIndex:",_45,i);
}
}
return _42;
}
})]);
