@STATIC;1.0;I;21;Foundation/CPObject.jt;861;


objj_executeFile("Foundation/CPObject.j", NO);

{var the_class = objj_allocateClassPair(CPView, "TextfieldView"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("textfield2")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("init"), function $TextfieldView__init(self, _cmd)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("TextfieldView").super_class }, "initWithFrame:", CGRectMake( 10,10,10,10 ));
        var textfield = objj_msgSend(CPTextField, "textFieldWithStringValue:placeholder:width:", "test", "", 5);
        objj_msgSend(self, "addSubview:", textfield);
    return self;
}
},["id"]), new objj_method(sel_getUid("setObjectValue:"), function $TextfieldView__setObjectValue_(self, _cmd, object)
{ with(self)
{

}
},["void","CPObject"])]);
}

