@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Page.ji;10;PageView.ji;20;PageViewController.jt;6151;objj_executeFile("Foundation/CPObject.j", NO);
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
},["void","CPNotification"]), new objj_method(sel_getUid("resetData"), function $AppController__resetData(self, _cmd)
{ with(self)
{
    rootPage = objj_msgSend(objj_msgSend(Page, "alloc"), "init");
    objj_msgSend(rootPage, "setTitle:", objj_msgSend(appnameField, "objectValue"));
    pageViewController.page = rootPage;
    appId = null;
}
},["void"]), new objj_method(sel_getUid("awakeFromCib"), function $AppController__awakeFromCib(self, _cmd)
{ with(self)
{
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
    objj_msgSend(self, "resetData");
}
},["void"]), new objj_method(sel_getUid("pageDidChange:"), function $AppController__pageDidChange_(self, _cmd, notification)
{ with(self)
{
    objj_msgSend(saveButton, "setEnabled:", rootPage.title.length > 0);
}
},["void","CPNotification"]), new objj_method(sel_getUid("controlTextDidChange:"), function $AppController__controlTextDidChange_(self, _cmd, sender)
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
        alert("Saved!");
    }
    if(data != '') {
        objj_msgSend(self, "didReceiveLoadData:", data);
    } else {
        alert('Couldn\'t find Agenda: "' + rootPage.title + '"');
        objj_msgSend(self, "resetData");
        objj_msgSend(self, "myRefresh")
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
    console.log("didReceiveResponse for URL:" + objj_msgSend(response, "URL"));
}
},["void","CPURLConnection","CPHTTPURLResponse"])]);
}

