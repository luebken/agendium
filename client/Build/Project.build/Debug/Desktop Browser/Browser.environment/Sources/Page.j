@STATIC;1.0;I;21;Foundation/CPObject.jt;2720;



objj_executeFile("Foundation/CPObject.j", NO);


{var the_class = objj_allocateClassPair(CPObject, "Page"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("title"), new objj_ivar("subtitle"), new objj_ivar("children"), new objj_ivar("ancestor")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("title"), function $Page__title(self, _cmd)
{ with(self)
{
return title;
}
},["id"]),
new objj_method(sel_getUid("setTitle:"), function $Page__setTitle_(self, _cmd, newValue)
{ with(self)
{
title = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("subtitle"), function $Page__subtitle(self, _cmd)
{ with(self)
{
return subtitle;
}
},["id"]),
new objj_method(sel_getUid("setSubtitle:"), function $Page__setSubtitle_(self, _cmd, newValue)
{ with(self)
{
subtitle = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("children"), function $Page__children(self, _cmd)
{ with(self)
{
return children;
}
},["id"]),
new objj_method(sel_getUid("setChildren:"), function $Page__setChildren_(self, _cmd, newValue)
{ with(self)
{
children = newValue;
}
},["void","id"]),
new objj_method(sel_getUid("ancestor"), function $Page__ancestor(self, _cmd)
{ with(self)
{
return ancestor;
}
},["id"]),
new objj_method(sel_getUid("setAncestor:"), function $Page__setAncestor_(self, _cmd, newValue)
{ with(self)
{
ancestor = newValue;
}
},["void","id"]), new objj_method(sel_getUid("init"), function $Page__init(self, _cmd)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("Page").super_class }, "init");
    children = objj_msgSend(objj_msgSend(CPArray, "alloc"), "init");
    return self;
}
},["id"]), new objj_method(sel_getUid("initWithTitle:andSubtitle:"), function $Page__initWithTitle_andSubtitle_(self, _cmd, newtitle, newsubtitle)
{ with(self)
{
    self = objj_msgSend(self, "init");
    title = newtitle;
    subtitle = newsubtitle;
    return self;
}
},["id","CPString","CPString"]), new objj_method(sel_getUid("addChild:"), function $Page__addChild_(self, _cmd, child)
{ with(self)
{
    objj_msgSend(child, "setAncestor:", self);
    objj_msgSend(children, "addObject:", child);
}
},["id","Page"]), new objj_method(sel_getUid("removeChild:"), function $Page__removeChild_(self, _cmd, index)
{ with(self)
{
    objj_msgSend(children, "removeObjectAtIndex:", index);
}
},["id","int"]), new objj_method(sel_getUid("description"), function $Page__description(self, _cmd)
{ with(self)
{
    return title;
}
},["CPString"])]);
class_addMethods(meta_class, [new objj_method(sel_getUid("initFromJSONObjects:"), function $Page__initFromJSONObjects_(self, _cmd, jsonObjects)
{ with(self)
{

}
},["CPArray","CPArray"])]);
}