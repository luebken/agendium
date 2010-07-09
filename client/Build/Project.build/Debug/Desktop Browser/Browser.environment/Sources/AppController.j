@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;10;PageView.ji;20;PageViewController.jt;5372;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("Page.j", YES);
objj_executeFile("PageView.j", YES);
objj_executeFile("PageViewController.j", YES);
{var the_class = objj_allocateClassPair(CPObject, "AppController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("theWindow"), new objj_ivar("box"), new objj_ivar("saveButton"), new objj_ivar("loadButton"), new objj_ivar("rootPage"), new objj_ivar("titleLabel"), new objj_ivar("appnameField"), new objj_ivar("pageView"), new objj_ivar("pageViewController"), new objj_ivar("baseURL"), new objj_ivar("listConnection")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("applicationDidFinishLaunching:"), function $AppController__applicationDidFinishLaunching_(self, _cmd, aNotification)
{ with(self)
{
    objj_msgSend(titleLabel, "setFont:", objj_msgSend(CPFont, "boldSystemFontOfSize:", 24.0));
    baseURL = "http://localhost:3000/";
}
},["void","CPNotification"]), new objj_method(sel_getUid("awakeFromCib"), function $AppController__awakeFromCib(self, _cmd)
{ with(self)
{
    rootPage = objj_msgSend(objj_msgSend(Page, "alloc"), "init");
    objj_msgSend(self, "loadData");
    objj_msgSend(box, "setBorderType:", CPLineBorder);
    objj_msgSend(box, "setBorderWidth:", 1);
    objj_msgSend(box, "setBorderColor:", objj_msgSend(CPColor, "grayColor"));
    pageViewController = objj_msgSend(objj_msgSend(PageViewController, "alloc"), "initWithCibName:bundle:", "PageView", nil);
    objj_msgSend(pageViewController, "setPage:", rootPage);
    objj_msgSend(objj_msgSend(pageViewController, "view"), "setFrame:", CPRectMake(1,1,500, 350))
    objj_msgSend(pageView, "addSubview:", objj_msgSend(pageViewController, "view"));
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("pageDidChange:"), "PageChangedNotification", rootPage);
    objj_msgSend(saveButton, "setEnabled:", NO);
    objj_msgSend(loadButton, "setEnabled:", NO);
}
},["void"]), new objj_method(sel_getUid("pageDidChange:"), function $AppController__pageDidChange_(self, _cmd, notification)
{ with(self)
{
    objj_msgSend(saveButton, "setEnabled:", rootPage.title.length > 0);
}
},["void","CPNotification"]), new objj_method(sel_getUid("loadData"), function $AppController__loadData(self, _cmd)
{ with(self)
{
    var monday = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "Monday", "Sessions on Monday");
    var mSession1 = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "First Session", "9:00-11:00");
    var mSession2 = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "Second Session", "11:15-12:00");
    var mSession3 = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "Third Session", "13:00-15:00");
    objj_msgSend(monday, "addChild:", mSession1);
    objj_msgSend(monday, "addChild:", mSession2);
    objj_msgSend(monday, "addChild:", mSession3);
    var tuesday = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "Tuesday", "Sessions on Tuesday");
    var wednesday = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "Wednesday", "Sessions on Wednesday");
    var thursday = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "Thursday", "Sessions on Thursday");
    var friday = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "Friday", "Sessions on Friday");
    objj_msgSend(rootPage, "addChild:", monday);
    objj_msgSend(rootPage, "addChild:", tuesday);
    objj_msgSend(rootPage, "addChild:", wednesday);
    objj_msgSend(rootPage, "addChild:", thursday);
    objj_msgSend(rootPage, "addChild:", friday);
}
},["void"]), new objj_method(sel_getUid("controlTextDidChange:"), function $AppController__controlTextDidChange_(self, _cmd, sender)
{ with(self)
{
    var length = objj_msgSend(objj_msgSend(appnameField, "objectValue"), "length");
    objj_msgSend(rootPage, "setTitle:", objj_msgSend(appnameField, "objectValue"));
    objj_msgSend(self, "myRefresh");
}
},["void","id"]), new objj_method(sel_getUid("myRefresh"), function $AppController__myRefresh(self, _cmd)
{ with(self)
{
    var enable = rootPage.title.length > 0;
    objj_msgSend(saveButton, "setEnabled:", enable);
    objj_msgSend(loadButton, "setEnabled:", enable);
    objj_msgSend(pageViewController, "myRefresh");
}
},["void"]), new objj_method(sel_getUid("load:"), function $AppController__load_(self, _cmd, sender)
{ with(self)
{
    console.log("loading...");
    var request = objj_msgSend(CPURLRequest, "requestWithURL:", baseURL);
    objj_msgSend(request, "setHTTPMethod:", 'GET');
    listConnection = objj_msgSend(CPURLConnection, "connectionWithRequest:delegate:", request, self);
}
},["@action","id"]), new objj_method(sel_getUid("connection:didReceiveData:"), function $AppController__connection_didReceiveData_(self, _cmd, connection, data)
{ with(self)
{
    console.log("DATA: " + data);
    var obj = JSON.parse(data);
    console.log("obj: " + obj);
    console.log("obj[1].title: " + obj[0].title);
}
},["void","CPURLConnection","CPString"]), new objj_method(sel_getUid("save:"), function $AppController__save_(self, _cmd, sender)
{ with(self)
{
    console.log("saving...");
}
},["@action","id"])]);
}

