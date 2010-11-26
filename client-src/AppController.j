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
@import "NewTemplate.j"
@import "AgendiumConnection.j"
@import "Config.j"
@import "PreviewView.j"

@implementation AppController : CPObject
{
    @outlet CPWindow theWindow; //this "outlet" is connected automatically by the Cib
    @outlet CPBox box;
    @outlet CPButton saveButton;
    @outlet CPButton loadButton;
    @outlet CPButton previewButton;
    @outlet CPButton logoutButton;
    @outlet CPButton shareButton;

    @outlet PreviewView previewView;

    Page rootPage;
    @outlet CPTextField appnameField;
    @outlet CPTextField appnameProblemLabel;
    @outlet CPTextField buildDateLabel;

    @outlet CPView pageView;
    PageViewController pageViewController;
    CPString appId;
    CPString userid;
    CPString useremail @accessors;
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
    validName = !(containsWhiteSpace | length < 5);    
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


//
// private
//
- (void) refreshUIFromData {
    [saveButton setEnabled:validName && nameOKServer === 'true'];
    [shareButton setEnabled:validName && nameOKServer === 'true'];
    if(!validName) {
        var containsWhiteSpace = /\s/.test(rootPage.title);
        if(containsWhiteSpace) {
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
    rootPage = [[Page alloc] init];
    rootPage.navigationId = "r";
    pageViewController.page = rootPage;
    appId = null; 
    validName = true;
    namechanged = false;
    nameOKServer = 'true';
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
    [[[UserSettingsPanel alloc] init:self withUsername:self.useremail] orderFront:nil];
}

- (@action) new:(id)sender {
    [[[NewPanel alloc] init:self] orderFront:nil];
}
- (@action) save:(id)sender {
    if(validName && nameOKServer === 'true'){
        [aConnection saveAgenda:appId rootPage:rootPage userid:userid delegate:self];
    }
}
- (@action) share:(id)sender {
    [[[SharePanel alloc] init:self andAppname:rootPage.title] orderFront:nil];
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

- (void)didReceiveCheckName:(id)nameOK {
    self.nameOKServer = nameOK;
    [self refreshUIFromData];
}


- (void) webView:(CPWeView)webview didFinishLoadForFrame:(id) frame {
    var navId = pageViewController.page.navigationId;
    [previewView changePageTo:navId animate:NO reverse:NO];
}


-(void)failureWhileReceivingAgenda:(CPString)msg  {
    alert(msg);    
}

//LoginPanel and OpenPanel Delegate
- (void) panelDidClose:(id)tag data:(id)data {
    switch(tag){
        case "login":
            self.userid = data.userid;
            self.useremail = data.useremail;
            [theWindow orderFront:self];
            break;
        case "open":
            CPLog("Loading Agenda for " + self.userid + " and name " + data);
            [aConnection loadAgendaFor:self.userid andName:data withDelegate:self];
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
    } 
}

@end
