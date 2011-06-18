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
@import "Panels/LoginPanel.j"
@import "Panels/OpenPanel.j"
@import "Panels/SharePanel.j"
@import "Panels/NewPanel.j"
@import "Panels/UserSettingsPanel.j"
@import "Panels/SelectLogoPanel.j"
@import "Panels/IntroPanel.j"
@import "NewTemplate.j"
@import "AgendiumConnection.j"
@import "Config.j"
@import "PreviewView.j"

@implementation AppController : CPObject
{
    @outlet CPWindow theWindow;
    @outlet CPBox box;
    @outlet CPButton saveButton;
    @outlet CPButton loadButton;
    @outlet CPButton previewButton;
    @outlet CPButton logoutButton;
    @outlet CPButton shareButton;
    @outlet PreviewView previewView;
    @outlet CPTextField appnameField;
    @outlet CPTextField appnameProblemLabel;
    @outlet CPTextField buildDateLabel;
    @outlet CPView pageView;

    Page rootPage;
    PageViewController pageViewController;
    AgendiumConnection aConnection;
    
    CPString appId;
    CPDictionary user @accessors;
    BOOL validName;
    BOOL namechanged;
    BOOL nameOKServer;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    [theWindow orderOut:self];
    [[[LoginPanel alloc] init:self] orderFront:nil];
}

- (void)awakeFromCib
{
    [box setBorderType:CPLineBorder]; 
    [box setBorderWidth:1]; 
    [box setBorderColor:[CPColor grayColor]];  

    pageViewController = [[PageViewController alloc] initWithCibName:@"PageView"
                                                        bundle:nil];
    [pageViewController setPage:rootPage];
    [[pageViewController view] setFrame:CPRectMake(1, 1, 550, 501)]
    [pageView addSubview:[pageViewController view]];

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

    //TODO isnt fired at the moment
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
    
    [previewView setFrameLoadDelegate:self];
    [pageViewController setDelegate:previewView];

    [logoutButton setBordered:NO]; 
    [logoutButton setImage:[[CPImage alloc] initWithContentsOfFile:"Resources/logout2.png"]];
    logoutButton._DOMElement.style.textDecoration = "underline";
    logoutButton._DOMElement.style.cursor = "pointer"; 

    [appnameProblemLabel setObjectValue:""];

    aConnection = [[AgendiumConnection alloc] init];
    
    [appnameField setValue:[CPColor lightGrayColor] forThemeAttribute:"text-color" inState:CPTextFieldStatePlaceholder];
    
    [buildDateLabel setObjectValue:BUILDDATE];
    
    [self resetData];
    [self validateName];
    [self refreshUIFromData];
}



- (void) pageDidChange: (CPNotification) notification {
    //FIXME: notification.object is nil !
    [saveButton setEnabled:rootPage.title.length > 0];
}

//CPTextField Delegate
- (void)controlTextDidChange:(id)sender {
    namechanged = true;
    [rootPage setTitle:[appnameField objectValue]];
    [self validateName];
    [self refreshUIFromData];
}

- (void)validateName {
    var appName = [appnameField objectValue];
    var length = [[appnameField objectValue] length];
    var containsWhiteSpace = /\s/.test(appName);
    self.validName = !(containsWhiteSpace | length < 5);    
    if(self.validName) {
        [aConnection checkAppName:appName forId:appId delegate:self];
    }
}

//
// private
//
- (void) refreshUIFromData {
    [saveButton setEnabled:validName && nameOKServer];
    [shareButton setEnabled:validName && nameOKServer];
    if(!self.validName) {
        var containsWhiteSpace = /\s/.test(rootPage.title);
        if(containsWhiteSpace) {
            [appnameProblemLabel setObjectValue:"< Please remove whitespaces."];
        } else if(rootPage.title.length < 5) {
            [appnameProblemLabel setObjectValue:""];            
        } else {
            [appnameProblemLabel setObjectValue:""];            
        }
    } else if(!nameOKServer){
        [appnameProblemLabel setObjectValue:"< Name is already taken."];
    } else {
        [appnameProblemLabel setObjectValue:""];
    }
    
    [pageViewController myRefresh];
    if(appId){
        var applink = BASEURL + "m/" + rootPage.title;
        var previewlink = BASEURL + "prev/" + appId;
        [previewView setMainFrameURL:previewlink];        
        [previewButton setTitle:applink]; 
        [previewButton sizeToFit];        
    } else {
        [previewButton setTitle:""]; 
        //FIXME preview ohne ständiges nachladen 
        [previewView setMainFrameURL:BASEURL + "preview"];
    }
}

- (void)resetData {
    self.rootPage = [[Page alloc] init];
    self.pageViewController.page = rootPage;
    self.appId = undefined; 
    self.validName = true;
    self.namechanged = false;
    self.nameOKServer = true;
    [self controlTextDidChange:null];
}

- (void) openMobileApp {
    if(namechanged) {
        window.alert('Please save before opening the app.')
    } else {
        var link = BASEURL + "m/" + rootPage.title;
        window.open (link,"mywindow");
    }
}

//
// Actions
//
- (@action) load:(id)sender {
    var name = [appnameField objectValue];
    [[[OpenPanel alloc] initWithName:name andDelegate:self] orderFront:nil];    
}
- (@action) login:(id)sender {
    [[[UserSettingsPanel alloc] init:self withUsername:self.user.email] orderFront:nil];
}
- (@action) new:(id)sender {
    [[[NewPanel alloc] init:self] orderFront:nil];
}
- (@action) save:(id)sender {
    if(validName && nameOKServer){
        [aConnection saveAgenda:appId rootPage:rootPage userid:user.id delegate:self];
    }
}
- (@action) share:(id)sender {
    [[[SharePanel alloc] init:self andAppname:rootPage.title] orderFront:nil];
}
- (@action) selectLogo:(id)sender {
    [[[SelectLogoPanel alloc] initWithUrl:self.rootPage.logourl andDelegate:self] orderFront:nil];    
}

//
// AgendiumConnection Delegate
//
-(void)didReceiveAgenda:(id)appId2 withRootPage:(Page)newRootpage  {
    self.appId = appId2;
    if(newRootpage) {
        self.rootPage = newRootpage;
        [appnameField setObjectValue:newRootpage.title];        
        [pageViewController setPage:newRootpage];
    }
    namechanged = false;
    [self validateName];
    [self refreshUIFromData];
}

- (void)didReceiveCheckName:(BOOL)nameOK {
    self.nameOKServer = nameOK;
    [self refreshUIFromData];
}


- (void) webView:(CPWeView)webview didFinishLoadForFrame:(id) frame {
    var navId = pageViewController.page.navigationId;
    [previewView changePageTo:navId animate:NO reverse:NO];
    [[previewView windowScriptObject] evaluateWebScript:'removeEventsForPreview();'];    
}


-(void)failureWhileReceivingAgenda:(CPString)msg  {
    alert(msg);    
}

//LoginPanel and OpenPanel Delegate
- (void) panelDidClose:(id)tag data:(id)data {
    switch(tag){
        case "login":
            self.user = data;
            [theWindow orderFront:self];
            [[[IntroPanel alloc] initWithDelegate:self] orderFront:nil];    
            break;
        case "open":
            CPLog("Loading Agenda for " + self.user.id + " and name " + data);
            [aConnection loadAgendaFor:self.user.id andName:data withDelegate:self];
            break;
        case "empty":
            [appnameField setObjectValue:""];
            [self resetData];
            [self didReceiveAgenda:undefined withRootPage:undefined];
            break;
        case "threedaytwotracks":
        case "onedayonetrack":
            [appnameField setObjectValue:""];
            [self resetData];
            var obj = JSON.parse([NewTemplate jsonDataForTemplate:tag withStartingDate:data]);
            var rootPage = [Page initFromJSONObject:obj.rootpage andNavigationId:"r"];
            [self didReceiveAgenda:undefined withRootPage:rootPage];        
            break;   
        case "logout":
            history.go(-1);
            break;
        case "setlogo":
            self.rootPage.logourl = data;
            break;
    } 
}

@end
