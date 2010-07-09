@STATIC;1.0;I;15;AppKit/CPView.jt;545;


objj_executeFile("AppKit/CPView.j", NO);


{var the_class = objj_allocateClassPair(CPView, "PageView"),
meta_class = the_class.isa;objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $PageView__initWithFrame_(self, _cmd, aRect)
{ with(self)
{
    if (self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("PageView").super_class }, "initWithFrame:", aRect))
    {
        console.log('PageView.initWithFrame');
    }
    return self;
}
},["id","CGRect"])]);
}

