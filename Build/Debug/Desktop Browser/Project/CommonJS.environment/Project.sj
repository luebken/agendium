@STATIC;1.0;p;15;AppController.jt;7486;@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;18;ButtonColumnView.ji;10;PageView.ji;20;PageViewController.jt;7368;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("Page.j", YES);
objj_executeFile("ButtonColumnView.j", YES);
objj_executeFile("PageView.j", YES);
objj_executeFile("PageViewController.j", YES);
{var the_class = objj_allocateClassPair(CPObject, "AppController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("theWindow"), new objj_ivar("scrollView"), new objj_ivar("table"), new objj_ivar("box"), new objj_ivar("deleteButton"), new objj_ivar("saveButton"), new objj_ivar("rootPage"), new objj_ivar("titleLabel"), new objj_ivar("idField"), new objj_ivar("pageView")]);
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
    var table = objj_msgSend(objj_msgSend(CPTableView, "alloc"), "initWithFrame:", CGRectMake(0.0, 0.0, 200.0, 500.0));
    var pageViewController = objj_msgSend(objj_msgSend(PageViewController, "alloc"), "initWithCibName:bundle:", "PageView", nil);
    objj_msgSend(pageView, "addSubview:", objj_msgSend(pageViewController, "view"));
    var column1 = objj_msgSend(objj_msgSend(CPTableColumn, "alloc"), "initWithIdentifier:", "title");
    objj_msgSend(objj_msgSend(column1, "headerView"), "setStringValue:", "Title");
    objj_msgSend(column1, "setWidth:", 200.0);
    objj_msgSend(column1, "setEditable:", YES);
    objj_msgSend(table, "addTableColumn:", column1);
    var column2 = objj_msgSend(objj_msgSend(CPTableColumn, "alloc"), "initWithIdentifier:", "subtitle");
    objj_msgSend(objj_msgSend(column2, "headerView"), "setStringValue:", "Subtitle");
    objj_msgSend(column2, "setWidth:", 260.0);
    objj_msgSend(column2, "setEditable:", YES);
    objj_msgSend(table, "addTableColumn:", column2);
    var button = objj_msgSend(objj_msgSend(ButtonColumnView, "alloc"), "initWithFrame:", CGRectMake(0.0, 0.0, 10.0, 20.0));
    var column3 = objj_msgSend(objj_msgSend(CPTableColumn, "alloc"), "initWithIdentifier:", "button");
    objj_msgSend(column3, "setDataView:", button);
    objj_msgSend(column3, "setWidth:", 20.0);
    objj_msgSend(column3, "setEditable:", YES);
    objj_msgSend(table, "addTableColumn:", column3);
    objj_msgSend(table, "setUsesAlternatingRowBackgroundColors:", YES);
    objj_msgSend(table, "setRowHeight:", 50);
    objj_msgSend(table, "setDataSource:", self);
    objj_msgSend(table, "setDelegate:", self);
    objj_msgSend(table, "setAllowsColumnSelection:", YES);
    objj_msgSend(deleteButton, "setEnabled:", NO);
    objj_msgSend(saveButton, "setEnabled:", NO);
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("tableViewSelectionDidChange:"), CPTableViewSelectionDidChangeNotification, nil);
    objj_msgSend(idField, "becomeFirstResponder")
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
    return objj_msgSend(objj_msgSend(rootPage, "children"), "count");
}
},["int","CPTableView"]), new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"), function $AppController__tableView_objectValueForTableColumn_row_(self, _cmd, tableView, tableColumn, row)
{ with(self)
{
    var page = objj_msgSend(objj_msgSend(rootPage, "children"), "objectAtIndex:", row);
    if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "title")) {
        return objj_msgSend(page, "title");
    } else if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "subtitle")) {
        return objj_msgSend(page, "subtitle");
    } else {
        return row + "";
    }
}
},["id","CPTableView","CPTableColumn","int"]), new objj_method(sel_getUid("tableView:setObjectValue:forTableColumn:row:"), function $AppController__tableView_setObjectValue_forTableColumn_row_(self, _cmd, aTableView, aValue, tableColumn, row)
{ with(self)
{
    var page = objj_msgSend(objj_msgSend(rootPage, "children"), "objectAtIndex:", row);
    if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "title")) {
        objj_msgSend(page, "setTitle:", aValue);
    } else {
        objj_msgSend(page, "setSubtitle:", aValue);
    }
}
},["void","CPTableView","id","CPTableColumn","int"]), new objj_method(sel_getUid("tableViewSelectionDidChange:"), function $AppController__tableViewSelectionDidChange_(self, _cmd, notification)
{ with(self)
{
    var chosenRow = objj_msgSend(objj_msgSend(table, "selectedRowIndexes"), "firstIndex");
    objj_msgSend(deleteButton, "setEnabled:", chosenRow > -1)
}
},["void","CPNotification"]), new objj_method(sel_getUid("addItemToList:"), function $AppController__addItemToList_(self, _cmd, sender)
{ with(self)
{
    var newpage = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "A title", "A subtitle");
    objj_msgSend(rootPage, "addChild:", newpage);
    objj_msgSend(table, "reloadData");
}
},["@action","id"]), new objj_method(sel_getUid("deleteItemFromList:"), function $AppController__deleteItemFromList_(self, _cmd, sender)
{ with(self)
{
    objj_msgSend(rootPage, "removeChild:", objj_msgSend(table, "selectedRow"));
    objj_msgSend(table, "deselectAll");
    objj_msgSend(table, "reloadData");
    objj_msgSend(self, "tableViewSelectionDidChange:", null);
}
},["@action","id"]), new objj_method(sel_getUid("controlTextDidChange:"), function $AppController__controlTextDidChange_(self, _cmd, sender)
{ with(self)
{
    var length = objj_msgSend(objj_msgSend(idField, "objectValue"), "length");
    objj_msgSend(saveButton, "setEnabled:", length > 0);
}
},["void","id"])]);
}

p;18;ButtonColumnView.jt;2066;@STATIC;1.0;I;15;AppKit/CPView.jt;2027;


objj_executeFile("AppKit/CPView.j", NO);


{var the_class = objj_allocateClassPair(CPView, "ButtonColumnView"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("button"), new objj_ivar("row")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $ButtonColumnView__initWithFrame_(self, _cmd, rect)
{ with(self)
{
        self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ButtonColumnView").super_class }, "initWithFrame:", rect);
        button = objj_msgSend(CPButton, "buttonWithTitle:", ">");
        objj_msgSend(button, "setCenter:", CPPointMake(10, 25));

        objj_msgSend(self, "addSubview:", button);
        objj_msgSend(button, "setTarget:", self);
        objj_msgSend(button, "setAction:", sel_getUid("actionHandler:"));

        return self;
}
},["id","CGRect"]), new objj_method(sel_getUid("setObjectValue:"), function $ButtonColumnView__setObjectValue_(self, _cmd, anObject)
{ with(self)
{
    row = anObject;
    objj_msgSend(button, "setTitle:", ">");
}
},["void","Object"]), new objj_method(sel_getUid("initWithCoder:"), function $ButtonColumnView__initWithCoder_(self, _cmd, aCoder)
{ with(self)
{
        self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ButtonColumnView").super_class }, "initWithCoder:", aCoder);
        button = objj_msgSend(aCoder, "decodeObjectForKey:", "button");
        return self;
}
},["id","CPCoder"]), new objj_method(sel_getUid("encodeWithCoder:"), function $ButtonColumnView__encodeWithCoder_(self, _cmd, aCoder)
{ with(self)
{
        objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ButtonColumnView").super_class }, "encodeWithCoder:", aCoder);
        objj_msgSend(aCoder, "encodeObject:forKey:", button, "button");
}
},["void","CPCoder"]), new objj_method(sel_getUid("actionHandler:"), function $ButtonColumnView__actionHandler_(self, _cmd, sender)
{ with(self)
{
    console.log("handled " + row);
}
},["void","id"])]);
}

p;6;main.jt;295;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jt;209;objj_executeFile("Foundation/Foundation.j", NO);
objj_executeFile("AppKit/AppKit.j", NO);
objj_executeFile("AppController.j", YES);
main= function(args, namedArgs)
{
    CPApplicationMain(args, namedArgs);
}

p;6;Page.jt;2228;@STATIC;1.0;I;21;Foundation/CPObject.jt;2183;



objj_executeFile("Foundation/CPObject.j", NO);


{var the_class = objj_allocateClassPair(CPObject, "Page"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("title"), new objj_ivar("subtitle"), new objj_ivar("children")]);
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
}p;10;PageView.jt;584;@STATIC;1.0;I;15;AppKit/CPView.jt;546;


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

p;20;PageViewController.jt;457;@STATIC;1.0;I;21;Foundation/CPObject.jt;413;


objj_executeFile("Foundation/CPObject.j", NO);

{var the_class = objj_allocateClassPair(CPViewController, "PageViewController"),
meta_class = the_class.isa;objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("testMethod:"), function $PageViewController__testMethod_(self, _cmd, sender)
{ with(self)
{
    console.log('action from ' + sender);
}
},["@action","id"])]);
}

e;