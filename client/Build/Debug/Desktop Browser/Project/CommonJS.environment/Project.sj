@STATIC;1.0;p;15;AppController.jt;6015;@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;10;PageView.ji;20;PageViewController.jt;5920;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("Page.j", YES);
objj_executeFile("PageView.j", YES);
objj_executeFile("PageViewController.j", YES);
{var the_class = objj_allocateClassPair(CPObject, "AppController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("theWindow"), new objj_ivar("box"), new objj_ivar("saveButton"), new objj_ivar("loadButton"), new objj_ivar("rootPage"), new objj_ivar("titleLabel"), new objj_ivar("appnameField"), new objj_ivar("pageView"), new objj_ivar("pageViewController"), new objj_ivar("baseURL"), new objj_ivar("appId"), new objj_ivar("listConnection"), new objj_ivar("saveConnection")]);
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
    var request = objj_msgSend(CPURLRequest, "requestWithURL:", baseURL+"agenda/"+rootPage.title);
    objj_msgSend(request, "setHTTPMethod:", 'GET');
    listConnection = objj_msgSend(CPURLConnection, "connectionWithRequest:delegate:", request, self);
}
},["@action","id"]), new objj_method(sel_getUid("save:"), function $AppController__save_(self, _cmd, sender)
{ with(self)
{
    console.log("saving...");
    var request = objj_msgSend(CPURLRequest, "requestWithURL:", baseURL + "agenda");
    objj_msgSend(request, "setHTTPMethod:", 'POST');
    var jsonData = '{"_id":"' + appId + '", "rootpage":'+ objj_msgSend(rootPage, "toJSON") + '}';
    console.log("Saving JSON: " + jsonData);
    objj_msgSend(request, "setHTTPBody:", jsonData);
    objj_msgSend(request, "setValue:forHTTPHeaderField:", 'application/json', "Accept");
    objj_msgSend(request, "setValue:forHTTPHeaderField:", 'application/json', "Content-Type");
    saveConnection = objj_msgSend(CPURLConnection, "connectionWithRequest:delegate:", request, self);
}
},["@action","id"]), new objj_method(sel_getUid("connection:didReceiveData:"), function $AppController__connection_didReceiveData_(self, _cmd, connection, data)
{ with(self)
{
    console.log("didReceiveData: '" + data + "'");
    if(connection == saveConnection) {
        alert(data);
    }
    if(data != '') {
        objj_msgSend(self, "didReceiveLoadData:", data);
    } else {
        alert('Couldn\'t find Agenda: "' + rootPage.title + '"');
    }
}
},["void","CPURLConnection","CPString"]), new objj_method(sel_getUid("didReceiveLoadData:"), function $AppController__didReceiveLoadData_(self, _cmd, data)
{ with(self)
{
    try {
        var obj = JSON.parse(data);
        var rootPage = objj_msgSend(Page, "initFromJSONObject:", obj.rootpage);
        self.appId = obj._id;
        console.log('data._id:' + obj._id);
        objj_msgSend(pageViewController, "setPage:", rootPage);
        objj_msgSend(self, "myRefresh");
    } catch (e) {
        console.log("Error in didReceiveData. " + e);
        alert(e);
    }
}
},["void","CPString"]), new objj_method(sel_getUid("connection:didFailWithError:"), function $AppController__connection_didFailWithError_(self, _cmd, connection, error)
{ with(self)
{
    console.log("didFailWithError: " + error);
    alert(error);
}
},["void","CPURLConnection","id"]), new objj_method(sel_getUid("connection:didReceiveResponse:"), function $AppController__connection_didReceiveResponse_(self, _cmd, connection, response)
{ with(self)
{
    console.log("didReceiveResponse for URL" + objj_msgSend(response, "URL"));
}
},["void","CPURLConnection","CPHTTPURLResponse"])]);
}

p;18;ButtonColumnView.jt;2260;@STATIC;1.0;I;15;AppKit/CPView.jt;2221;


objj_executeFile("AppKit/CPView.j", NO);


{var the_class = objj_allocateClassPair(CPView, "ButtonColumnView"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("button"), new objj_ivar("row"), new objj_ivar("delegate")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:andDelegate:"), function $ButtonColumnView__initWithFrame_andDelegate_(self, _cmd, rect, delegate2)
{ with(self)
{
        self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ButtonColumnView").super_class }, "initWithFrame:", rect);
        button = objj_msgSend(CPButton, "buttonWithTitle:", ">");
        objj_msgSend(button, "setCenter:", CPPointMake(10, 25));

        objj_msgSend(self, "addSubview:", button);
        objj_msgSend(button, "setTarget:", self);
        objj_msgSend(button, "setAction:", sel_getUid("rowSelected:"));
        self.delegate = delegate2;
        return self;
}
},["id","CGRect","id"]), new objj_method(sel_getUid("setObjectValue:"), function $ButtonColumnView__setObjectValue_(self, _cmd, anObject)
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
},["void","CPCoder"]), new objj_method(sel_getUid("rowSelected:"), function $ButtonColumnView__rowSelected_(self, _cmd, sender)
{ with(self)
{
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "postNotificationName:object:", "RowClickedNotification", row);
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

p;6;Page.jt;3564;@STATIC;1.0;I;21;Foundation/CPObject.jt;3519;



objj_executeFile("Foundation/CPObject.j", NO);


{var the_class = objj_allocateClassPair(CPObject, "Page"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("title"), new objj_ivar("subtitle"), new objj_ivar("children"), new objj_ivar("ancestor")]);
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
},["void","id"]),
new objj_method(sel_getUid("ancestor"), function $Page__ancestor(self, _cmd)
{ with(self)
{
return ancestor;
}
},["id"]),
new objj_method(sel_getUid("setAncestor:"), function $Page__setAncestor_(self, _cmd, newValue)
{ with(self)
{
ancestor = newValue;
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
    objj_msgSend(child, "setAncestor:", self);
    objj_msgSend(children, "addObject:", child);
}
},["id","Page"]), new objj_method(sel_getUid("removeChild:"), function $Page__removeChild_(self, _cmd, index)
{ with(self)
{
    objj_msgSend(children, "removeObjectAtIndex:", index);
}
},["id","int"]), new objj_method(sel_getUid("toJSON"), function $Page__toJSON(self, _cmd)
{ with(self)
{
    var childrenJSON = '';
    for (var i=0; i < children.length; i++) {
        childrenJSON += objj_msgSend(children[i], "toJSON");
        childrenJSON += ',';
    }
    if(childrenJSON.length > 0) {
        childrenJSON = childrenJSON.substring(0, childrenJSON.length - 1);
    }
    return '{"title":"' + title + '","subtitle":"' + subtitle + '","children":[' + childrenJSON + ']}';
}
},["id"]), new objj_method(sel_getUid("description"), function $Page__description(self, _cmd)
{ with(self)
{
    return title;
}
},["CPString"])]);
class_addMethods(meta_class, [new objj_method(sel_getUid("initFromJSONObject:"), function $Page__initFromJSONObject_(self, _cmd, object)
{ with(self)
{
    var page = objj_msgSend(objj_msgSend(Page, "alloc"), "initWithTitle:andSubtitle:", object.title, object.subtitle);
    for (var i=0; i < object.children.length; i++) {
        var child = objj_msgSend(Page, "initFromJSONObject:", object.children[i]);
        objj_msgSend(page, "addChild:", child);
    }
    return page;
}
},["Page","id"])]);
}p;10;PageView.jt;583;@STATIC;1.0;I;15;AppKit/CPView.jt;545;


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

p;20;PageViewController.jt;8385;@STATIC;1.0;I;21;Foundation/CPObject.ji;18;ButtonColumnView.jt;8317;


objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("ButtonColumnView.j", YES);


{var the_class = objj_allocateClassPair(CPViewController, "PageViewController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("scrollView"), new objj_ivar("page"), new objj_ivar("deleteButton"), new objj_ivar("backButton"), new objj_ivar("editButton"), new objj_ivar("table"), new objj_ivar("titleField"), new objj_ivar("editing")]);
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
    objj_msgSend(backButton, "setEnabled:", NO);

    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("tableViewSelectionDidChange:"), CPTableViewSelectionDidChangeNotification, nil);

    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "addObserver:selector:name:object:", self, sel_getUid("rowClicked:"), "RowClickedNotification", nil);
}
},["void"]), new objj_method(sel_getUid("tableView:shouldEditTableColumn:row:"), function $PageViewController__tableView_shouldEditTableColumn_row_(self, _cmd, aTableView, tableColumn, row)
{ with(self)
{
    objj_msgSend(self, "toggleEditing:", aTableView);
    return self.editing;
}
},["BOOL","CPTableView","CPTableColumn","int"]), new objj_method(sel_getUid("toggleEditing:"), function $PageViewController__toggleEditing_(self, _cmd, sender)
{ with(self)
{
    var field;
    if(self.editing) {
        field = objj_msgSend(CPTextField, "labelWithTitle:", "");
        objj_msgSend(self, "setEditing:", NO);
        objj_msgSend(editButton, "setTitle:", "Edit");
    } else {
        field = objj_msgSend(CPTextField, "textFieldWithStringValue:placeholder:width:", "", "", 100);
        objj_msgSend(self, "setEditing:", YES);
        objj_msgSend(editButton, "setTitle:", "Done");

    }
    var cols = objj_msgSend(table, "tableColumns");
    objj_msgSend(cols[0], "setDataView:", field);
    objj_msgSend(cols[1], "setDataView:", field);

    objj_msgSend(self, "myRefresh");
}
},["@action","id"]), new objj_method(sel_getUid("numberOfRowsInTableView:"), function $PageViewController__numberOfRowsInTableView_(self, _cmd, tableView)
{ with(self)
{
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
},["@action","id"]), new objj_method(sel_getUid("rowClicked:"), function $PageViewController__rowClicked_(self, _cmd, notification)
{ with(self)
{
    var row = objj_msgSend(notification, "object");
    page = objj_msgSend(objj_msgSend(page, "children"), "objectAtIndex:", row);
    objj_msgSend(self, "myRefresh");

}
},["void","id"]), new objj_method(sel_getUid("backButtonClicked:"), function $PageViewController__backButtonClicked_(self, _cmd, sender)
{ with(self)
{
    page = objj_msgSend(page, "ancestor");
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
}
},["void"])]);
}

e;