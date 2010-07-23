@STATIC;1.0;I;21;Foundation/CPObject.jt;3605;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"Page"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("title"),new objj_ivar("subtitle"),new objj_ivar("children"),new objj_ivar("ancestor"),new objj_ivar("type"),new objj_ivar("attributes")]);
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
}),new objj_method(sel_getUid("type"),function(_17,_18){
with(_17){
return type;
}
}),new objj_method(sel_getUid("setType:"),function(_19,_1a,_1b){
with(_19){
type=_1b;
}
}),new objj_method(sel_getUid("attributes"),function(_1c,_1d){
with(_1c){
return attributes;
}
}),new objj_method(sel_getUid("setAttributes:"),function(_1e,_1f,_20){
with(_1e){
attributes=_20;
}
}),new objj_method(sel_getUid("init"),function(_21,_22){
with(_21){
_21=objj_msgSendSuper({receiver:_21,super_class:objj_getClass("Page").super_class},"init");
children=objj_msgSend(objj_msgSend(CPArray,"alloc"),"init");
attributes=objj_msgSend(CPDictionary,"dictionary");
type="Navigation";
return _21;
}
}),new objj_method(sel_getUid("initWithTitle:andSubtitle:andType:"),function(_23,_24,_25,_26,_27){
with(_23){
_23=objj_msgSend(_23,"init");
title=_25;
subtitle=_26;
type=_27;
return _23;
}
}),new objj_method(sel_getUid("addChild:"),function(_28,_29,_2a){
with(_28){
objj_msgSend(_2a,"setAncestor:",_28);
objj_msgSend(children,"addObject:",_2a);
}
}),new objj_method(sel_getUid("removeChild:"),function(_2b,_2c,_2d){
with(_2b){
objj_msgSend(children,"removeObjectAtIndex:",_2d);
}
}),new objj_method(sel_getUid("toJSON"),function(_2e,_2f){
with(_2e){
var _30="";
for(var i=0;i<children.length;i++){
_30+=objj_msgSend(children[i],"toJSON");
_30+=",";
}
if(_30.length>0){
_30=_30.substring(0,_30.length-1);
}
var _31="";
for(var i=0;i<objj_msgSend(attributes,"allKeys").length;i++){
var key=objj_msgSend(attributes,"allKeys")[i];
var _32=objj_msgSend(attributes,"objectForKey:",key);
_31+=JSON.stringify(key)+":"+JSON.stringify(_32);
_31+=",";
}
if(_31.length>0){
_31=_31.substring(0,_31.length-1);
}
var _33="{\"title\":\""+title;
if(subtitle){
_33+="\",\"subtitle\":\""+subtitle;
}
_33+="\",\"type\":\""+type+"\",\"children\":["+_30+"],\"attributes\":{"+_31+"}}";
return _33;
}
}),new objj_method(sel_getUid("description"),function(_34,_35){
with(_34){
return title;
}
}),new objj_method(sel_getUid("isNavigationType"),function(_36,_37){
with(_36){
return type==="Navigation";
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("initFromJSONObject:"),function(_38,_39,_3a){
with(_38){
var _3b=objj_msgSend(objj_msgSend(Page,"alloc"),"initWithTitle:andSubtitle:andType:",_3a.title,_3a.subtitle,_3a.type);
for(var i=0;i<_3a.children.length;i++){
var _3c=objj_msgSend(Page,"initFromJSONObject:",_3a.children[i]);
objj_msgSend(_3b,"addChild:",_3c);
}
for(var key in _3a.attributes){
objj_msgSend(objj_msgSend(_3b,"attributes"),"setValue:forKey:",_3a.attributes[key],key);
}
return _3b;
}
})]);
