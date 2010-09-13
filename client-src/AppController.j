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
@import "OpenPanel.j"
@import "NewPanel.j"
@import "NewTemplate.j"
@import "AgendiumConnection.j"
@import "Config.j"

@implementation AppController : CPObject
{
    @outlet CPWindow theWindow; //this "outlet" is connected automatically by the Cib
    @outlet CPBox box;
    @outlet CPButton saveButton;
    @outlet CPButton loadButton;
    @outlet CPButton previewButton;
    @outlet CPButton logoutButton;

    CPWebView previewView;

    Page rootPage;
    @outlet CPTextField appnameField;
    @outlet CPTextField appnameProblemLabel;
    @outlet CPTextField buildDateLabel;

    @outlet CPView pageView;
    PageViewController pageViewController;
    CPString appId;
    CPString nameOKServer;

    AgendiumConnection aConnection;
    
    BOOL validName;
    BOOL namechanged;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    [theWindow orderOut:self];
    [[[LoginPanel alloc] init:self] orderFront:nil];

}

- (void)awakeFromCib
{
    //[titleLabel setFont:[CPFont systemFontOfSize:18.0]];
    //titleLabel._DOMElement.setAttribute("styles", "text-shadow:0px 1px 0px white");
    //[titleLabel setTextShadowColor:[CPColor colorWithHexString:"aaaaaa"]];
    //[titleLabel setTextShadowOffset:CGSizeMake(1,1)];

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

    [[CPNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(save:)
               name:@"AddItemToListNotification"
             object:nil];

    [[CPNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(save:)
               name:@"EditingDoneNotification"
              object:nil];


    [previewButton setBordered:NO]; 
    previewButton._DOMElement.style.textDecoration = "underline";
    [previewButton setTextColor:[CPColor blueColor]]; 
    [previewButton setAlignment:CPLeftTextAlignment];
    [previewButton setTarget:self]; 
    [previewButton setAction:@selector(openMobileApp)]; 
    previewButton._DOMElement.style.cursor = "pointer"; 

    //previewView = [[CPWebView alloc] initWithFrame:CPRectMake(540, 100, 340, 520)];
    [previewView setFrame:CPRectMake(540, 100, 340, 520)];
    //[[theWindow contentView] addSubview:previewView];
    [previewView setFrameLoadDelegate:self];
    //[previewView setScrollMode:CPWebViewScrollAppKit];
    //[previewView._scrollView setAutohidesScrollers:YES];

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

    [appnameProblemLabel setObjectValue:""];

    aConnection = [[AgendiumConnection alloc] init];
    
    [appnameField setValue:[CPColor lightGrayColor] forThemeAttribute:"text-color" inState:CPTextFieldStatePlaceholder];
    
    [buildDateLabel setObjectValue:BUILDDATE];
    [self resetData];
    [self didReceiveAgenda:undefined];     
}



- (void) pageDidChange: (CPNotification) notification {
    //FIXME: notification.object is nil !
    [saveButton setEnabled:rootPage.title.length > 0];
}

//CPTextField Delegate
- (void)controlTextDidChange:(id)sender {
    namechanged = true;
    var appName = [appnameField objectValue];
    var length = [[appnameField objectValue] length];
    var containsWhiteSpace = /\s/.test(appName);
    validName = !(containsWhiteSpace | length < 5);    
    [rootPage setTitle:[appnameField objectValue]];
    [self refreshUIFromData];
    
    if(validName) {
        [aConnection checkAppName:appName forId:appId delegate:self];
    }
    
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

//
// private
//
- (void) refreshUIFromData {
    [saveButton setEnabled:validName && nameOKServer === 'true'];
    if(!validName) {
        var containsWhiteSpace = /\s/.test(rootPage.title);
        if(containsWhiteSpace){
            [appnameProblemLabel setObjectValue:"< Please remove whitespaces."];
        } else if(rootPage.title.length < 5) {
            [appnameProblemLabel setObjectValue:""];            
        } else {
            [appnameProblemLabel setObjectValue:""];            
        }
    } else if(nameOKServer === 'false'){
        [appnameProblemLabel setObjectValue:"< Name is already taken."];
    } else {
        [appnameProblemLabel setObjectValue:""];
    }
    
    [pageViewController myRefresh];
    if(appId){
        var applink = BASEURL + "a/" + rootPage.title;
        var previewlink = BASEURL + "prev/" + appId;
        [previewView setMainFrameURL:previewlink];
        [previewButton setTitle:applink]; 
    } else {
        [previewButton setTitle:""]; 
        //FIXME preview ohne ständiges nachladen 
        [previewView setMainFrameURL:BASEURL + "preview"];
    }
}
- (void)resetData {
    rootPage = [[Page alloc] init];
    [rootPage setTitle:[appnameField objectValue]];
    rootPage.navigationId = "r";
    pageViewController.page = rootPage;
    appId = null; 
}
- (void) openMobileApp {
    if(namechanged) {
        window.alert('Please save before opening the app.')
    } else {
        var link = BASEURL + "a/" + rootPage.title;
        window.open (link,"mywindow");
    }
}

//
// Actions
//
- (@action) load:(id)sender {
    [[[OpenPanel alloc] init:self] orderFront:nil];    
}
- (@action) login:(id)sender {
    //[[[LoginPanel alloc] init:self] orderFront:nil];
    history.go(-1);
}
- (@action) new:(id)sender {
    [[[NewPanel alloc] init:self] orderFront:nil];
}

- (@action) save:(id)sender {
    if(validName && nameOKServer === 'true'){
        [aConnection saveAgenda:appId rootPage:rootPage delegate:self];
    }
}

//
// AgendiumConnection Delegate
//
-(void)didReceiveAgenda:(id)appId2 withRootPage:(Page)newRootpage  {
    self.namechanged = false;
    [appnameField setObjectValue:newRootpage.title];
    self.appId = appId2;
    self.rootPage = newRootpage
    [pageViewController setPage:newRootpage];
    [self refreshUIFromData];
}
-(void)didReceiveAgenda:(id)appId2 {
    self.namechanged = false;    
    self.appId = appId2;
    [self refreshUIFromData];

}
- (void)didReceiveCheckName:(id)nameOK {
    console.log('didReceiveCheckName ' + nameOK);
    self.nameOKServer = nameOK;
    [self refreshUIFromData];
}

- (void) webView:(CPWeView)webview didFinishLoadForFrame:(id) frame {
    var page = [pageViewController page];
    var cmd = 'jQT.goTo("#' + page.navigationId + '");';
    //console.log("didFinishLoadForFrame " + cmd);
    [[previewView windowScriptObject] evaluateWebScript:cmd];
    //FIXME Here some redrawing action?
    //previewView._DOMElement.style.webkitTransformOrigin = "10 10";
    //[[theWindow contentView] layoutIfNeeded];
    //[[theWindow contentView] needsDisplay]; 
    //[[theWindow contentView] display]   
}


-(void)failureWhileReceivingAgenda:(CPString)msg  {
    alert(msg);    
    [self resetData];
    [self refreshUIFromData]
}

//LoginPanel and OpenPanel Delegate
- (void) panelDidClose:(id)tag data:(CPString)data {
    if(tag === "login") {
        [theWindow orderFront:self];
    }  
    if(tag === "open") {
        console.log("Loading Agenda for name: " + data);
        [aConnection loadAgenda:data delegate:self];
    }
    if(tag === "empty") {
        [appnameField setObjectValue:""];
        [self resetData];
        [self didReceiveAgenda:undefined];
    }
    if(tag === "threedaytwotracks" || tag === "onedayonetrack"){
        [appnameField setObjectValue:""];
        [self resetData];
        var obj = JSON.parse([NewTemplate data:tag]);
        var rootPage = [Page initFromJSONObject:obj.rootpage andNavigationId:"r"];
        [self didReceiveAgenda:undefined withRootPage:rootPage];        
    }
    
}





@end
