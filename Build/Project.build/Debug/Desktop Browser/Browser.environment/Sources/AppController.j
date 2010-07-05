@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;10;PageView.ji;20;PageViewController.jt;2915;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("Page.j", YES);
objj_executeFile("PageView.j", YES);
objj_executeFile("PageViewController.j", YES);
{var the_class = objj_allocateClassPair(CPObject, "AppController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("theWindow"), new objj_ivar("box"), new objj_ivar("saveButton"), new objj_ivar("rootPage"), new objj_ivar("titleLabel"), new objj_ivar("pageView")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("applicationDidFinishLaunching:"), function $AppController__applicationDidFinishLaunching_(self, _cmd, aNotification)
{ with(self)
{
    objj_msgSend(titleLabel, "setFont:", objj_msgSend(CPFont, "boldSystemFontOfSize:", 24.0));
}
},["void","CPNotification"]), new objj_method(sel_getUid("awakeFromCib"), function $AppController__awakeFromCib(self, _cmd)
{ with(self)
{
    rootPage = objj_msgSend(objj_msgSend(Page, "alloc"), "init");
    var monday = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "Monday", "Sessions on Monday");
    var tuesday = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "Tuesday", "Sessions on Tuesday");
    var wednesday = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "Wednesday", "Sessions on Wednesday");
    var thursday = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "Thursday", "Sessions on Thursday");
    var friday = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "Friday", "Sessions on Friday");
    objj_msgSend(rootPage, "addChild:", monday);
    objj_msgSend(rootPage, "addChild:", tuesday);
    objj_msgSend(rootPage, "addChild:", wednesday);
    objj_msgSend(rootPage, "addChild:", thursday);
    objj_msgSend(rootPage, "addChild:", friday);
    objj_msgSend(box, "setBorderType:", CPLineBorder);
    objj_msgSend(box, "setBorderWidth:", 1);
    objj_msgSend(box, "setBorderColor:", objj_msgSend(CPColor, "grayColor"));
    var pageViewController = objj_msgSend(objj_msgSend(PageViewController, "alloc"), "initWithCibName:bundle:", "PageView", nil);
    objj_msgSend(pageViewController, "setPage:", rootPage);
    objj_msgSend(objj_msgSend(pageViewController, "view"), "setFrame:", CPRectMake(1,1,500, 350))
    console.log('setPage');
    objj_msgSend(pageView, "addSubview:", objj_msgSend(pageViewController, "view"));
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("pageDidChange:"), "PageChangedNotification", rootPage);
    objj_msgSend(saveButton, "setEnabled:", NO);
}
},["void"]), new objj_method(sel_getUid("pageDidChange:"), function $AppController__pageDidChange_(self, _cmd, notification)
{ with(self)
{
    objj_msgSend(saveButton, "setEnabled:", rootPage.title.length > 0);
}
},["void","CPNotification"])]);
}

