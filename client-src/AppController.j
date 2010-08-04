/*
 * AppController.j
 * 
 *
 * Created by You on May 26, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "Page.j"
@import "PageView.j"
@import "PageViewController.j"
@import "LoginPanel.j"
@import "NewTemplate.j"
@import "AgendiumConnection.j"

@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    @outlet CPBox box;
    @outlet CPButton saveButton;
    @outlet CPButton loadButton;
    @outlet CPButton previewButton;
    @outlet CPButton logoutButton;
    @outlet CPWebView previewView;

    Page rootPage;
    @outlet CPTextField appnameField;
    @outlet CPView pageView;
    PageViewController pageViewController;
    CPString baseURL;
    CPString appId;
    
    AgendiumConnection aConnection;
    CPURLConnection listConnection;
    CPURLConnection saveConnection;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    [theWindow orderOut:self];
    [[[LoginPanel alloc] init:self] orderFront:nil];
}

- (void)resetData {
    rootPage = [[Page alloc] init];
    [rootPage setTitle:[appnameField objectValue]];
    rootPage.mobileNavId = "r";
    pageViewController.page = rootPage;
    appId = null;
}

- (void)awakeFromCib
{
    //[titleLabel setFont:[CPFont systemFontOfSize:18.0]];
    //titleLabel._DOMElement.setAttribute("styles", "text-shadow:0px 1px 0px white");
    //[titleLabel setTextShadowColor:[CPColor colorWithHexString:"aaaaaa"]];
    //[titleLabel setTextShadowOffset:CGSizeMake(1,1)];
    //baseURL = @"http://agendium.heroku.com/";
    baseURL = @"http://localhost:8000/";

    [box setBorderType:CPLineBorder]; 
    [box setBorderWidth:1]; 
    [box setBorderColor:[CPColor grayColor]];  

    pageViewController = [[PageViewController alloc] initWithCibName:@"PageView"
                                                        bundle:nil];
    [pageViewController setPage:rootPage];
    [pageViewController setDelegate:self];
    [[pageViewController view] setFrame:CPRectMake(1, 1, 550, 501)]
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
    [previewButton setAlignment:CPLeftTextAlignment];
    [previewButton setTarget:self]; 
    [previewButton setAction:@selector(openMobileApp)]; 
    previewButton._DOMElement.style.cursor = "pointer"; 

    //[previewView setScrollMode:CPWebViewScrollAppKit];
    //[previewView._scrollView setAutohidesScrollers:YES];

    [previewView setFrame:CPRectMake(540, 100, 340, 520)];
    previewView._DOMElement.style.webkitTransformOrigin = "10 10";
    previewView._DOMElement.style.webkitTransform = "scale(0.75)";
    //previewView._DOMElement.style.overflow = "hidden";
    
    //previewView._DOMElement.style.width = "340px";
    //previewView._DOMElement.style.height = "520px";
    
    //previewView._iframe.style.webkitTransformOrigin = "0 0"; 
    //previewView._iframe.style.webkitTransform = "scale(0.75)"; 
    //previewView._iframe.style.opacity = "0"; 
    //previewView._frameView._DOMElement.style.opacity = "0"; 
    //previewView._scrollView._DOMElement.style.opacity = "0"; 
    

    [logoutButton setBordered:NO]; 
    [logoutButton setImage:[[CPImage alloc] initWithContentsOfFile:"Resources/logout2.png"]];
    logoutButton._DOMElement.style.textDecoration = "underline";
    logoutButton._DOMElement.style.cursor = "pointer"; 

    aConnection = [[AgendiumConnection alloc] init];
    
    [self resetData];
 
    [appnameField setValue:[CPColor lightGrayColor] forThemeAttribute:"text-color" inState:CPTextFieldStatePlaceholder];
    [self myRefresh]
}

- (void) openMobileApp {
    var applink = baseURL + "a/" + appId;
    window.open (applink,"mywindow");
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

/* TODO: Wie ist das Handling mit Load/Save?
- (void)controlTextDidEndEditing:(id)sender {
    [self load:sender];
}
*/

//PageViewController Delegate
- (void) selectedPage:(Page) page reverse:(Boolean) reverse {
    var cmd = 'jQT.goTo("#' + page.navigationId + '", "slide"';
    if(reverse) cmd += ', "reverse"';
    cmd += ');'
    console.log("cmd " + cmd);
    [[previewView windowScriptObject] evaluateWebScript:cmd];
}


- (void) myRefresh {
    var enable = rootPage.title.length > 0;
    [saveButton setEnabled:enable];
    [loadButton setEnabled:enable];
    [pageViewController myRefresh];
    var applink = baseURL + "a/" + appId;
    if(appId){
        [previewView setMainFrameURL:applink];
        [previewButton setTitle:applink]; 
    } else {
        [previewButton setTitle:""]; 
        //FIXME preview ohne ständiges nachladen [previewView setMainFrameURL:baseURL + "preview"];
    }
}

- (@action) load:(id)sender {
    [aConnection loadAgenda:rootPage.title delegate:self];
}
//AgendiumConnection Delegate
-(void)didReceiveAgenda:(id)appId2 withRootPage:(Page)page  {
    self.appId = appId2;
    [pageViewController setPage:page];
    [self myRefresh];
}
//AgendiumConnection Delegate
-(void)failureWhileReceivingAgenda:(CPString)msg  {
    alert(msg);    
    [self resetData];
    [self myRefresh]
}

- (@action) login:(id)sender {
    //[[[LoginPanel alloc] init:self] orderFront:nil];
    history.go(-1);
}
//LoginPanel Delegate
- (void) panelDidClose:(id)tag {
    if(tag == 1) {
        console.log(@"login success");
        [theWindow orderFront:self];
    } else {
        console.log(@"login canceled");
        history.go(-1);
    }
}

- (@action) new:(id)sender {
    [appnameField setObjectValue:""];
    [self resetData];
    var data = [NewTemplate data];
    [self didReceiveLoadData:data];
}

- (@action) save:(id)sender {
    var request = [CPURLRequest requestWithURL:baseURL + "agenda"];
    [request setHTTPMethod:'POST'];
    var jsonData = '{"_id":"' + appId + '", "rootpage":'+ [rootPage toJSON] + '}';
    console.log("Saving JSON: " + jsonData)
    [request setHTTPBody:jsonData];
    [request setValue:'application/json' forHTTPHeaderField:"Accept"];
    [request setValue:'application/json' forHTTPHeaderField:"Content-Type"];
    
    //console.log("[request HTTPBody]: " + [request HTTPBody]);
    //console.log("[request allHTTPHeaderFields]: " + [request allHTTPHeaderFields]);
    
    saveConnection = [CPURLConnection connectionWithRequest:request delegate:self];
}

//CPURLConnection delegate
-(void)connection:(CPURLConnection)connection didReceiveData:(CPString)data {
    console.log("didReceiveData: '" + data + "'");
    if(connection == saveConnection) {
        var popup = [[CPAlert alloc] init];
        //[alert setWindowStyle:CPHUDBackgroundWindowMask];
        [popup setAlertStyle:CPInformationalAlertStyle];
        [popup setMessageText:"Saved!"];
        [popup addButtonWithTitle:@"OK"];
        [popup runModal];
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
