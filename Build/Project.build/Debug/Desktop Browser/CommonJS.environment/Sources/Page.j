@STATIC;1.0;I;21;Foundation/CPObject.jt;930;



objj_executeFile("Foundation/CPObject.j", NO);


{var the_class = objj_allocateClassPair(CPObject, "Page"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("title")]);
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
},["void","id"]), new objj_method(sel_getUid("initWithTitle:"), function $Page__initWithTitle_(self, _cmd, newtitle)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("Page").super_class }, "init");
    title = newtitle;
    return self;
}
},["id","CPString"]), new objj_method(sel_getUid("description"), function $Page__description(self, _cmd)
{ with(self)
{
    return title;
}
},["CPString"])]);
}