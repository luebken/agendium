@STATIC;1.0;I;21;Foundation/CPObject.ji;18;ButtonColumnView.ji;21;CPPropertyAnimation.jt;12351;


objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("ButtonColumnView.j", YES);
objj_executeFile("CPPropertyAnimation.j", YES);


{var the_class = objj_allocateClassPair(CPViewController, "PageViewController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("scrollView"), new objj_ivar("page"), new objj_ivar("deleteButton"), new objj_ivar("addButton"), new objj_ivar("backButton"), new objj_ivar("editButton"), new objj_ivar("pagetypeButton"), new objj_ivar("table"), new objj_ivar("titleField"), new objj_ivar("itemsLabel"), new objj_ivar("editing")]);
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
},["void","id"]),
new objj_method(sel_getUid("editing"), function $PageViewController__editing(self, _cmd)
{ with(self)
{
return editing;
}
},["id"]),
new objj_method(sel_getUid("setEditing:"), function $PageViewController__setEditing_(self, _cmd, newValue)
{ with(self)
{
editing = newValue;
}
},["void","id"]), new objj_method(sel_getUid("initWithCibName:bundle:"), function $PageViewController__initWithCibName_bundle_(self, _cmd, aCibNameOrNil, aCibBundleOrNil)
{ with(self)
{
    if (self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("PageViewController").super_class }, "initWithCibName:bundle:", aCibNameOrNil, aCibBundleOrNil))
    {


    }
    return self;
}
},["id","CPString","CPBundle"]), new objj_method(sel_getUid("awakeFromCib"), function $PageViewController__awakeFromCib(self, _cmd)
{ with(self)
{
    table = objj_msgSend(objj_msgSend(CPTableView, "alloc"), "initWithFrame:", CGRectMake(0.0, 0.0, 200.0, 600.0));

    var column1 = objj_msgSend(objj_msgSend(CPTableColumn, "alloc"), "initWithIdentifier:", "first");
    objj_msgSend(objj_msgSend(column1, "headerView"), "setStringValue:", "Title");
    objj_msgSend(column1, "setWidth:", 200.0);
    objj_msgSend(column1, "setEditable:", YES);
    objj_msgSend(table, "addTableColumn:", column1);

    var column2 = objj_msgSend(objj_msgSend(CPTableColumn, "alloc"), "initWithIdentifier:", "second");
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
    objj_msgSend(table, "setAllowsColumnSelection:", NO);

    objj_msgSend(scrollView, "setDocumentView:", table);

    objj_msgSend(deleteButton, "setEnabled:", NO);
    objj_msgSend(backButton, "setEnabled:", NO);
    objj_msgSend(pagetypeButton, "removeAllItems");
    objj_msgSend(pagetypeButton, "addItemsWithTitles:",  ['Navigation', 'Detail']);

    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("tableViewSelectionDidChange:"), CPTableViewSelectionDidChangeNotification, nil);

    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("rowClicked:"), "RowClickedNotification", nil);
}
},["void"]), new objj_method(sel_getUid("tableView:shouldEditTableColumn:row:"), function $PageViewController__tableView_shouldEditTableColumn_row_(self, _cmd, aTableView, tableColumn, row)
{ with(self)
{
    objj_msgSend(self, "setEditing:", NO);
    objj_msgSend(self, "toggleEditing:", aTableView);
    return YES;
}
},["BOOL","CPTableView","CPTableColumn","int"]), new objj_method(sel_getUid("toggleEditing:"), function $PageViewController__toggleEditing_(self, _cmd, sender)
{ with(self)
{
    var field;
    if(self.editing) {
        field = objj_msgSend(CPTextField, "labelWithTitle:", "");



        objj_msgSend(field, "setVerticalAlignment:", CPCenterTextAlignment);



        objj_msgSend(self, "setEditing:", NO);
        objj_msgSend(editButton, "setTitle:", "Edit");
        objj_msgSend(editButton, "unsetThemeState:", CPThemeStateDefault);

    } else {
        field = objj_msgSend(CPTextField, "textFieldWithStringValue:placeholder:width:", "", "", 100);
        objj_msgSend(self, "setEditing:", YES);
        objj_msgSend(editButton, "setTitle:", "Done");
        objj_msgSend(editButton, "setThemeState:", CPThemeStateDefault);
    }
    var cols = objj_msgSend(table, "tableColumns");
    objj_msgSend(cols[0], "setDataView:", field);
    objj_msgSend(cols[1], "setDataView:", field);
    objj_msgSend(self, "myRefresh");

}
},["@action","id"]), new objj_method(sel_getUid("numberOfRowsInTableView:"), function $PageViewController__numberOfRowsInTableView_(self, _cmd, tableView)
{ with(self)
{
    if(objj_msgSend(page, "isNavigationType")) {
        return objj_msgSend(objj_msgSend(page, "children"), "count");
    } else {
        return objj_msgSend(objj_msgSend(objj_msgSend(page, "attributes"), "allKeys"), "count");
    }
}
},["int","CPTableView"]), new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"), function $PageViewController__tableView_objectValueForTableColumn_row_(self, _cmd, tableView, tableColumn, row)
{ with(self)
{
    if(objj_msgSend(page, "isNavigationType")) {
        var pageAtRow = objj_msgSend(objj_msgSend(page, "children"), "objectAtIndex:", row);
        if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "first")) {
            return objj_msgSend(pageAtRow, "title");
        } else if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "second")) {
            return objj_msgSend(pageAtRow, "subtitle");
        } else {
            return row + "";
        }
    } else {
        var key = objj_msgSend(objj_msgSend(page, "attributes"), "allKeys")[row];
        var value = objj_msgSend(objj_msgSend(page, "attributes"), "objectForKey:", key);
        if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "first")) {
            return key;
        } else if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "second")) {
            return value;
        }
    }
}
},["id","CPTableView","CPTableColumn","int"]), new objj_method(sel_getUid("tableView:setObjectValue:forTableColumn:row:"), function $PageViewController__tableView_setObjectValue_forTableColumn_row_(self, _cmd, aTableView, aValue, tableColumn, row)
{ with(self)
{
    if(objj_msgSend(page, "isNavigationType")) {
        var pageAtRow = objj_msgSend(objj_msgSend(page, "children"), "objectAtIndex:", row);
        if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "first")) {
            objj_msgSend(pageAtRow, "setTitle:", aValue);
        } else {
            objj_msgSend(pageAtRow, "setSubtitle:", aValue);
        }
    } else {
        var col0 = objj_msgSend(table, "tableColumns")[0];
        var col1 = objj_msgSend(table, "tableColumns")[1]
        var oldAttributeKey = objj_msgSend(self, "tableView:objectValueForTableColumn:row:", table, col0, row);
        var oldValue = objj_msgSend(self, "tableView:objectValueForTableColumn:row:", table, col1, row);
        if(objj_msgSend(objj_msgSend(tableColumn, "identifier"), "isEqual:", "first")) {
            objj_msgSend(objj_msgSend(page, "attributes"), "removeObjectForKey:", oldAttributeKey);
            objj_msgSend(objj_msgSend(page, "attributes"), "setValue:forKey:", oldValue, aValue);
        } else {
            objj_msgSend(objj_msgSend(page, "attributes"), "setValue:forKey:", aValue, oldAttributeKey);
        }
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
    if(objj_msgSend(page, "isNavigationType")) {
        var newpage = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:andType:", "The title of a subpage", "The optional subtitle of a subpage",  "Navigation");
        objj_msgSend(page, "addChild:", newpage);
    } else {
        objj_msgSend(objj_msgSend(page, "attributes"), "setValue:forKey:", "A value", "A attribute");
    }
    objj_msgSend(table, "reloadData");
}
},["@action","id"]), new objj_method(sel_getUid("deleteItemFromList:"), function $PageViewController__deleteItemFromList_(self, _cmd, sender)
{ with(self)
{
    var row = objj_msgSend(table, "selectedRow");
    if(objj_msgSend(page, "isNavigationType")) {
        objj_msgSend(page, "removeChild:", row);
    } else {
        var key = objj_msgSend(objj_msgSend(page, "attributes"), "allKeys")[row];
        objj_msgSend(objj_msgSend(page, "attributes"), "removeObjectForKey:", key);
    }
    objj_msgSend(table, "deselectAll");
    objj_msgSend(table, "reloadData");
    objj_msgSend(self, "tableViewSelectionDidChange:", null);
}
},["@action","id"]), new objj_method(sel_getUid("rowClicked:"), function $PageViewController__rowClicked_(self, _cmd, notification)
{ with(self)
{

    if(objj_msgSend(page, "isNavigationType")) {
        var row = objj_msgSend(notification, "object");
        page = objj_msgSend(objj_msgSend(page, "children"), "objectAtIndex:", row);

        objj_msgSend(objj_msgSend(CPPropertyAnimation, "slideLeft:view:", self, scrollView), "startAnimation");

        objj_msgSend(self, "myRefresh");
    }

}
},["void","id"]), new objj_method(sel_getUid("animationDidEnd:"), function $PageViewController__animationDidEnd_(self, _cmd, animation)
{ with(self)
{
    console.log("animationDidEnd");
}
},["void","CPAnimation"]), new objj_method(sel_getUid("backButtonClicked:"), function $PageViewController__backButtonClicked_(self, _cmd, sender)
{ with(self)
{
    objj_msgSend(objj_msgSend(CPPropertyAnimation, "slideRight:view:", self, scrollView), "startAnimation");

    page = objj_msgSend(page, "ancestor");
    objj_msgSend(self, "myRefresh");
}
},["@action","id"]), new objj_method(sel_getUid("pageTypeClicked:"), function $PageViewController__pageTypeClicked_(self, _cmd, sender)
{ with(self)
{
    var title = objj_msgSend(objj_msgSend(sender, "selectedItem"), "title");
    page.type = title;
    objj_msgSend(self, "myRefresh");
}
},["@action","id"]), new objj_method(sel_getUid("myRefresh"), function $PageViewController__myRefresh(self, _cmd)
{ with(self)
{
    objj_msgSend(table, "reloadData");
    objj_msgSend(backButton, "setEnabled:", page.ancestor != null);



    objj_msgSend(table, "deselectAll");
    var title = page.title;
    if(page.subtitle != null) {
        title += " (" + page.subtitle + ")";
    }
    objj_msgSend(titleField, "setObjectValue:", title);

    var header1 = objj_msgSend(objj_msgSend(table, "tableColumns")[0], "headerView");
    var header2 = objj_msgSend(objj_msgSend(table, "tableColumns")[1], "headerView");
    if(objj_msgSend(page, "isNavigationType")) {
        objj_msgSend(header1, "setStringValue:", "Title");
        objj_msgSend(header2, "setStringValue:", "Subtitle");
        objj_msgSend(itemsLabel, "setStringValue:", "Subpages:");
    } else {
        objj_msgSend(header1, "setStringValue:", "Attribute");
        objj_msgSend(header2, "setStringValue:", "Value");
        objj_msgSend(itemsLabel, "setStringValue:", "Attributes:");

    }
    objj_msgSend(pagetypeButton, "selectItemWithTitle:", page.type);
}
},["void"])]);
}

