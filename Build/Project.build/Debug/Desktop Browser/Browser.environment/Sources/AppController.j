@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;14;ButtonColumn.jt;3115;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("Page.j", YES);
objj_executeFile("ButtonColumn.j", YES);
{var the_class = objj_allocateClassPair(CPObject, "AppController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("theWindow"), new objj_ivar("table"), new objj_ivar("box"), new objj_ivar("rootPages")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("applicationDidFinishLaunching:"), function $AppController__applicationDidFinishLaunching_(self, _cmd, aNotification)
{ with(self)
{
    console.log("applicationDidFinishLaunching");
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
    var column1 = objj_msgSend(objj_msgSend(CPTableColumn, "alloc"), "init");
    objj_msgSend(column1, "setWidth:", 350.0);
    objj_msgSend(column1, "setIdentifier:", 1);
    objj_msgSend(table, "addTableColumn:", column1);
    var column2 = objj_msgSend(objj_msgSend(CPTableColumn, "alloc"), "init");
    var button = objj_msgSend(objj_msgSend(ButtonColumn, "alloc"), "initWithTarget:andAction:", self, sel_getUid("deleteItemFromList:"));
    objj_msgSend(column2, "setDataView:", button);
    objj_msgSend(table, "addTableColumn:", column2);
    objj_msgSend(table, "setUsesAlternatingRowBackgroundColors:", YES);
    objj_msgSend(table, "setRowHeight:", 50);
    objj_msgSend(table, "setDataSource:", self);
}
},["void"]), new objj_method(sel_getUid("numberOfRowsInTableView:"), function $AppController__numberOfRowsInTableView_(self, _cmd, tableView)
{ with(self)
{
    return objj_msgSend(rootPages, "count");
}
},["int","CPTableView"]), new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"), function $AppController__tableView_objectValueForTableColumn_row_(self, _cmd, tableView, tableColumn, row)
{ with(self)
{
    console.log(" [rootPages objectAtIndex:"+row+"] " + objj_msgSend(rootPages, "objectAtIndex:", row))
        return objj_msgSend(rootPages, "objectAtIndex:", row);
}
},["id","CPTableView","CPTableColumn","int"]), new objj_method(sel_getUid("addItemToList:"), function $AppController__addItemToList_(self, _cmd, sender)
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

