/*
 * AppController.j
 * test2
 *
 * Created by You on May 26, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "Page.j"
@import "PageView.j"
@import "PageViewController.j"

@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    @outlet CPBox box;
    @outlet CPButton saveButton;
    @outlet CPButton loadButton;
    @outlet CPButton previewButton;
    Page rootPage;
    @outlet CPTextField titleLabel;
    @outlet CPTextField appnameField;
    @outlet CPView pageView;
    PageViewController pageViewController;
    CPString baseURL;
    CPString appId;
    CPURLConnection listConnection;
    CPURLConnection saveConnection;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
}

- (void)resetData {
    rootPage = [[Page alloc] init];
    [rootPage setTitle:[appnameField objectValue]];
    pageViewController.page = rootPage;
    appId = null;
}

- (void)awakeFromCib
{
    [titleLabel setFont:[CPFont boldSystemFontOfSize:24.0]]; 
    baseURL = @"http://localhost:3000/";

    [box setBorderType:CPLineBorder]; 
    [box setBorderWidth:1]; 
    [box setBorderColor:[CPColor grayColor]];  

    pageViewController = [[PageViewController alloc] initWithCibName:@"PageView"
                                                        bundle:nil];
    [pageViewController setPage:rootPage];
    [[pageViewController view] setFrame:CPRectMake( 1 , 1, 500, 395)]
    [pageView addSubview:[pageViewController view]];

    //[scrollView setDocumentView:[pageViewController view]];

    [[CPNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(pageDidChange:)
               name:@"PageChangedNotification"
             object:rootPage];

    [previewButton setBordered:NO]; 
    previewButton._DOMElement.style.textDecoration = "underline";
    [previewButton setTextColor:[CPColor blueColor]]; 
    [previewButton setTarget:self]; 
    [previewButton setAction:@selector(setWindowLocation)]; 
    previewButton._DOMElement.style.cursor = "pointer"; 

    [self resetData];
 
    //Dummy Start
    [rootPage setTitle:"FOWA2010"]
    [appnameField setObjectValue:"FOWA2010"];
    //Dummy END


    [self myRefresh]
    //[idField bectEnabled:YESo;der] 
    //[CPMenu setMenuBarVisible:YES];

}

- (void) setWindowLocation {
    var applink = baseURL + "a/" + appId;
    window.location = applink;
}

- (void) pageDidChange: (CPNotification) notification {
    //FIXME: notification.object is nil !
    [saveButton setEnabled:rootPage.title.length > 0];
}

//CPTextField Delegate
- (void)controlTextDidChange:(id)sender {
    var length = [[appnameField objectValue] length];
    [rootPage setTitle:[appnameField objectValue]];

    [self myRefresh];
/*
    [[CPNotificationCenter defaultCenter] 
        postNotificationName:@"PageChangedNotification" 
        object:page]; 
*/
}

- (void) myRefresh {
    var enable = rootPage.title.length > 0;
    [saveButton setEnabled:enable];
    [loadButton setEnabled:enable];
    [pageViewController myRefresh];
    var applink = baseURL + "a/" + appId;
    if(appId){
        [previewButton setTitle:applink]; 
    } else {
        [previewButton setTitle:""]; 
    }

}

- (@action) load:(id)sender {
    console.log(@"loading...");
    var request = [CPURLRequest requestWithURL:baseURL+"agenda/"+rootPage.title];
    [request setHTTPMethod:'GET'];
    listConnection = [CPURLConnection connectionWithRequest:request delegate:self];
}

- (@action) save:(id)sender {
    var request = [CPURLRequest requestWithURL:baseURL + "agenda"];
    [request setHTTPMethod:'POST'];
    var jsonData = '{"_id":"' + appId + '", "rootpage":'+ [rootPage toJSON] + '}';
    console.log("Saving JSON: " + jsonData);
    [request setHTTPBody:jsonData];
    [request setValue:'application/json' forHTTPHeaderField:"Accept"];
    [request setValue:'application/json' forHTTPHeaderField:"Content-Type"];
    saveConnection = [CPURLConnection connectionWithRequest:request delegate:self];
}

//CPURLConnection delegate
-(void)connection:(CPURLConnection)connection didReceiveData:(CPString)data {
    console.log("didReceiveData: '" + data + "'");
    if(connection == saveConnection) {
        alert("Saved!");
    }

    if(data != '') {
        [self didReceiveLoadData:data];
    } else {
        alert('Couldn\'t find Agenda: "' + rootPage.title + '"');    
        [self resetData];
        [self myRefresh]
    }
}

-(void)didReceiveLoadData:(CPString)data {
    try {
        var obj = JSON.parse(data);
        var rootPage = [Page initFromJSONObject:obj.rootpage];
        self.appId = obj._id;
        [pageViewController setPage:rootPage];
        [self myRefresh];
    } catch (e) {
        console.log(@"Error in didReceiveData. " + e);
        alert(e);
    } 
}

//CPURLConnection delegate
-(void)connection:(CPURLConnection)connection didFailWithError:(id)error {
    console.log("didFailWithError: " + error);
    alert(error);
}
//CPURLConnection delegate
-(void)connection:(CPURLConnection)connection didReceiveResponse:(CPHTTPURLResponse)response {
    console.log("didReceiveResponse for URL:" + [response URL]);
}


@end
