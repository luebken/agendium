@STATIC;1.0;p;15;AppController.jt;4109;@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;14;ButtonColumn.jt;4035;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("Page.j", YES);
objj_executeFile("ButtonColumn.j", YES);
{var the_class = objj_allocateClassPair(CPObject, "AppController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("theWindow"), new objj_ivar("scrollView"), new objj_ivar("table"), new objj_ivar("box"), new objj_ivar("rootPages")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("applicationDidFinishLaunching:"), function $AppController__applicationDidFinishLaunching_(self, _cmd, aNotification)
{ with(self)
{
}
},["void","CPNotification"]), new objj_method(sel_getUid("awakeFromCib"), function $AppController__awakeFromCib(self, _cmd)
{ with(self)
{
    console.log("awakeFromCib:");
    rootPages = objj_msgSend(objj_msgSend(CPArray, "alloc"), "init");
    rootPages[0] = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:", "A new Page");
    rootPages[1] = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:", "A second Page");
    objj_msgSend(box, "setBorderType:", CPLineBorder);
    objj_msgSend(box, "setBorderWidth:", 1);
    objj_msgSend(box, "setBorderColor:", objj_msgSend(CPColor, "grayColor"));
    var table = objj_msgSend(objj_msgSend(CPTableView, "alloc"), "initWithFrame:", CGRectMake(0.0, 0.0, 200.0, 500.0));
    objj_msgSend(scrollView, "setDocumentView:", table);
    var column1 = objj_msgSend(objj_msgSend(CPTableColumn, "alloc"), "init");
    objj_msgSend(objj_msgSend(column1, "headerView"), "setStringValue:", "Title");
    objj_msgSend(column1, "setWidth:", 250.0);
    objj_msgSend(column1, "setEditable:", YES);
    objj_msgSend(table, "addTableColumn:", column1);
    var column2 = objj_msgSend(objj_msgSend(CPTableColumn, "alloc"), "init");
    objj_msgSend(objj_msgSend(column2, "headerView"), "setStringValue:", "Subtitle");
    objj_msgSend(column2, "setEditable:", YES);
    objj_msgSend(table, "addTableColumn:", column2);
    objj_msgSend(table, "setUsesAlternatingRowBackgroundColors:", YES);
    objj_msgSend(table, "setRowHeight:", 50);
    objj_msgSend(table, "setDataSource:", self);
    objj_msgSend(table, "setDelegate:", self);
    objj_msgSend(table, "setAllowsColumnSelection:", YES);
}
},["void"]), new objj_method(sel_getUid("tableView:shouldEditTableColumn:row:"), function $AppController__tableView_shouldEditTableColumn_row_(self, _cmd, aTableView, tableColumn, row)
{ with(self)
{
    console.log('shouldEditTableColumn');
    return YES;
}
},["BOOL","CPTableView","CPTableColumn","int"]), new objj_method(sel_getUid("numberOfRowsInTableView:"), function $AppController__numberOfRowsInTableView_(self, _cmd, tableView)
{ with(self)
{
    return objj_msgSend(rootPages, "count");
}
},["int","CPTableView"]), new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"), function $AppController__tableView_objectValueForTableColumn_row_(self, _cmd, tableView, tableColumn, row)
{ with(self)
{
        return objj_msgSend(rootPages, "objectAtIndex:", row);
}
},["id","CPTableView","CPTableColumn","int"]), new objj_method(sel_getUid("tableView:setObjectValue:forTableColumn:row:"), function $AppController__tableView_setObjectValue_forTableColumn_row_(self, _cmd, aTableView, aValue, tableColumn, row)
{ with(self)
{
    console.log('setObjectValue ' + aValue);
    objj_msgSend(objj_msgSend(rootPages, "objectAtIndex:", row), "setTitle:", aValue);
    objj_msgSend(table, "reloadData");
}
},["void","CPTableView","id","CPTableColumn","int"]), new objj_method(sel_getUid("addItemToList:"), function $AppController__addItemToList_(self, _cmd, sender)
{ with(self)
{
    objj_msgSend(rootPages, "addObject:", objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:", "A new Page"));
    objj_msgSend(table, "reloadData");
}
},["@action","id"]), new objj_method(sel_getUid("deleteItemFromList:"), function $AppController__deleteItemFromList_(self, _cmd, sender)
{ with(self)
{
    console.log("delete " + objj_msgSend(table, "selectedRow"));
}
},["@action","id"])]);
}

p;14;ButtonColumn.jt;1446;@STATIC;1.0;I;21;Foundation/CPObject.jt;1401;


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

p;6;main.jt;295;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jt;209;objj_executeFile("Foundation/Foundation.j", NO);
objj_executeFile("AppKit/AppKit.j", NO);
objj_executeFile("AppController.j", YES);
main= function(args, namedArgs)
{
    CPApplicationMain(args, namedArgs);
}

p;6;Page.jt;974;@STATIC;1.0;I;21;Foundation/CPObject.jt;930;



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
}e;