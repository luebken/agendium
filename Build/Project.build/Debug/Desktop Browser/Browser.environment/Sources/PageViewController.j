@STATIC;1.0;I;21;Foundation/CPObject.ji;18;ButtonColumnView.jt;7003;


objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("ButtonColumnView.j", YES);


{var the_class = objj_allocateClassPair(CPViewController, "PageViewController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("scrollView"), new objj_ivar("page"), new objj_ivar("deleteButton"), new objj_ivar("backButton"), new objj_ivar("table"), new objj_ivar("titleField")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("page"), function $PageViewController__page(self, _cmd)
{ with(self)
{
return page;
}
},["id"]),
new objj_method(sel_getUid("setPage:"), function $PageViewController__setPage_(self, _cmd, newValue)
{ with(self)
{
page = newValue;
}
},["void","id"]), new objj_method(sel_getUid("initWithCibName:bundle:"), function $PageViewController__initWithCibName_bundle_(self, _cmd, aCibNameOrNil, aCibBundleOrNil)
{ with(self)
{
    if (self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("PageViewController").super_class }, "initWithCibName:bundle:", aCibNameOrNil, aCibBundleOrNil))
    {
        console.log('PageViewController1 :' + scrollView);

    }
    return self;
}
},["id","CPString","CPBundle"]), new objj_method(sel_getUid("awakeFromCib"), function $PageViewController__awakeFromCib(self, _cmd)
{ with(self)
{
    table = objj_msgSend(objj_msgSend(CPTableView, "alloc"), "initWithFrame:", CGRectMake(0.0, 0.0, 200.0, 500.0));

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

    var button = objj_msgSend(objj_msgSend(ButtonColumnView, "alloc"), "initWithFrame:andDelegate:", CGRectMake(0.0, 0.0, 10.0, 20.0), self);
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

    objj_msgSend(scrollView, "setDocumentView:", table);

    objj_msgSend(deleteButton, "setEnabled:", NO);


    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("tableViewSelectionDidChange:"), CPTableViewSelectionDidChangeNotification, nil);

    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("rowClicked:"), "RowClickedNotification", nil);
}
},["void"]), new objj_method(sel_getUid("numberOfRowsInTableView:"), function $PageViewController__numberOfRowsInTableView_(self, _cmd, tableView)
{ with(self)
{
    console.log('numberOfRowsInTableView ' + objj_msgSend(objj_msgSend(page, "children"), "count"));
    return objj_msgSend(objj_msgSend(page, "children"), "count");
}
},["int","CPTableView"]), new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"), function $PageViewController__tableView_objectValueForTableColumn_row_(self, _cmd, tableView, tableColumn, row)
{ with(self)
{
    var pageAtRow = objj_msgSend(objj_msgSend(page, "children"), "objectAtIndex:", row);
    if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "title")) {
        return objj_msgSend(pageAtRow, "title");
    } else if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "subtitle")) {
        return objj_msgSend(pageAtRow, "subtitle");
    } else {
        return row + "";
    }
}
},["id","CPTableView","CPTableColumn","int"]), new objj_method(sel_getUid("tableView:setObjectValue:forTableColumn:row:"), function $PageViewController__tableView_setObjectValue_forTableColumn_row_(self, _cmd, aTableView, aValue, tableColumn, row)
{ with(self)
{
    var pageAtRow = objj_msgSend(objj_msgSend(page, "children"), "objectAtIndex:", row);
    if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "title")) {
        objj_msgSend(pageAtRow, "setTitle:", aValue);
    } else {
        objj_msgSend(pageAtRow, "setSubtitle:", aValue);
    }
}
},["void","CPTableView","id","CPTableColumn","int"]), new objj_method(sel_getUid("tableViewSelectionDidChange:"), function $PageViewController__tableViewSelectionDidChange_(self, _cmd, notification)
{ with(self)
{
    var chosenRow = objj_msgSend(objj_msgSend(table, "selectedRowIndexes"), "firstIndex");
    objj_msgSend(deleteButton, "setEnabled:", chosenRow > -1)
}
},["void","CPNotification"]), new objj_method(sel_getUid("addItemToList:"), function $PageViewController__addItemToList_(self, _cmd, sender)
{ with(self)
{
    var newpage = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", "A title", "A subtitle");
    objj_msgSend(page, "addChild:", newpage);
    objj_msgSend(table, "reloadData");
}
},["@action","id"]), new objj_method(sel_getUid("deleteItemFromList:"), function $PageViewController__deleteItemFromList_(self, _cmd, sender)
{ with(self)
{
    objj_msgSend(page, "removeChild:", objj_msgSend(table, "selectedRow"));
    objj_msgSend(table, "deselectAll");
    objj_msgSend(table, "reloadData");
    objj_msgSend(self, "tableViewSelectionDidChange:", null);
}
},["@action","id"]), new objj_method(sel_getUid("controlTextDidChange:"), function $PageViewController__controlTextDidChange_(self, _cmd, sender)
{ with(self)
{
    var length = objj_msgSend(objj_msgSend(titleField, "objectValue"), "length");
    objj_msgSend(page, "setTitle:", objj_msgSend(titleField, "objectValue"));
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "postNotificationName:object:", "PageChangedNotification", page);
}
},["void","id"]), new objj_method(sel_getUid("rowClicked:"), function $PageViewController__rowClicked_(self, _cmd, notification)
{ with(self)
{
    var row = objj_msgSend(notification, "object");
    page = objj_msgSend(objj_msgSend(page, "children"), "objectAtIndex:", row);
    objj_msgSend(table, "reloadData");
}
},["void","id"]), new objj_method(sel_getUid("backButtonClicked:"), function $PageViewController__backButtonClicked_(self, _cmd, sender)
{ with(self)
{
    page = objj_msgSend(page, "ancestor");
    objj_msgSend(table, "reloadData");
}
},["@action","id"])]);
}

