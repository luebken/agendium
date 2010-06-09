@STATIC;1.0;I;21;Foundation/CPObject.jt;1401;


objj_executeFile("Foundation/CPObject.j", NO);

{var the_class = objj_allocateClassPair(CPView, "ButtonColumn"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("buttons"), new objj_ivar("target"), new objj_ivar("action")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithTarget:andAction:"), function $ButtonColumn__initWithTarget_andAction_(self, _cmd, target2, action2)
{ with(self)
{
        console.log('ButtonColumn.init');
        self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ButtonColumn").super_class }, "initWithFrame:", CGRectMake( 10,10,10,10 ));
        buttons = objj_msgSend(objj_msgSend(CPArray, "alloc"), "init");

        self.target = target2;
        self.action = action2;
        return self;
}
},["id","CPObject","SEL"]), new objj_method(sel_getUid("setObjectValue:"), function $ButtonColumn__setObjectValue_(self, _cmd, object)
{ with(self)
{
    var button = objj_msgSend(CPButton, "buttonWithTitle:", "Delete");
    objj_msgSend(button, "setCenter:", CPPointMake(50, 25));
    objj_msgSend(buttons, "addObject:", button);
        objj_msgSend(button, "setTarget:", self.target);
        objj_msgSend(button, "setAction:", self.action);
    objj_msgSend(self, "addSubview:", button);
    console.log("setObjectValue " + object + " at " + self);
}
},["void","CPObject"])]);
}

