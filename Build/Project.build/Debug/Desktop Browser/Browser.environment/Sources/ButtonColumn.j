@STATIC;1.0;I;21;Foundation/CPObject.jt;1996;


objj_executeFile("Foundation/CPObject.j", NO);

{var the_class = objj_allocateClassPair(CPView, "ButtonColumn"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("button"), new objj_ivar("row")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $ButtonColumn__initWithFrame_(self, _cmd, rect)
{ with(self)
{
        self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ButtonColumn").super_class }, "initWithFrame:", rect);
        button = objj_msgSend(CPButton, "buttonWithTitle:", ">");
        objj_msgSend(button, "setCenter:", CPPointMake(10, 25));

        objj_msgSend(self, "addSubview:", button);
        objj_msgSend(button, "setTarget:", self);
        objj_msgSend(button, "setAction:", sel_getUid("actionHandler:"));

        return self;
}
},["id","CGRect"]), new objj_method(sel_getUid("setObjectValue:"), function $ButtonColumn__setObjectValue_(self, _cmd, anObject)
{ with(self)
{
    row = anObject;
    objj_msgSend(button, "setTitle:", ">");
}
},["void","Object"]), new objj_method(sel_getUid("initWithCoder:"), function $ButtonColumn__initWithCoder_(self, _cmd, aCoder)
{ with(self)
{
        self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ButtonColumn").super_class }, "initWithCoder:", aCoder);
        button = objj_msgSend(aCoder, "decodeObjectForKey:", "button");
        return self;
}
},["id","CPCoder"]), new objj_method(sel_getUid("encodeWithCoder:"), function $ButtonColumn__encodeWithCoder_(self, _cmd, aCoder)
{ with(self)
{
        objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ButtonColumn").super_class }, "encodeWithCoder:", aCoder);
        objj_msgSend(aCoder, "encodeObject:forKey:", button, "button");
}
},["void","CPCoder"]), new objj_method(sel_getUid("actionHandler:"), function $ButtonColumn__actionHandler_(self, _cmd, sender)
{ with(self)
{
    console.log("handled " + row);
}
},["void","id"])]);
}

