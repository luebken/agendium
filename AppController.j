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
    Page rootPage;
    @outlet CPTextField titleLabel;
    @outlet CPTextField appnameField;
    @outlet CPView pageView;
    PageViewController pageViewController;

    CPString baseURL;
    CPURLConnection listConnection;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    [titleLabel setFont:[CPFont boldSystemFontOfSize:24.0]]; 
    baseURL = @"http://localhost:3000/json";
}

- (void)awakeFromCib
{
    rootPage = [[Page alloc] init];
    [self loadData];

    [box setBorderType:CPLineBorder]; 
    [box setBorderWidth:1]; 
    [box setBorderColor:[CPColor grayColor]];  

    pageViewController = [[PageViewController alloc] initWithCibName:@"PageView"
                                                        bundle:nil];
    [pageViewController setPage:rootPage];
    [[pageViewController view] setFrame:CPRectMake(1,1,500, 350)]
    [pageView addSubview:[pageViewController view]];

    //[scrollView setDocumentView:[pageViewController view]];

    [[CPNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(pageDidChange:)
               name:@"PageChangedNotification"
             object:rootPage];

    [saveButton setEnabled:NO];
    [loadButton setEnabled:NO];

    //[idField becomeFirstResponder] 

    //[CPMenu setMenuBarVisible:YES];

}

- (void) pageDidChange: (CPNotification) notification {
    //FIXME: notification.object is nil !
    [saveButton setEnabled:rootPage.title.length > 0];
}

- (void) loadData {
    //Sample Data
    var monday = [[Page alloc] initWithTitle:"Monday" andSubtitle:"Sessions on Monday"];
    var mSession1 = [[Page alloc] initWithTitle:"First Session" andSubtitle:"9:00-11:00"];
    var mSession2 = [[Page alloc] initWithTitle:"Second Session" andSubtitle:"11:15-12:00"];
    var mSession3 = [[Page alloc] initWithTitle:"Third Session" andSubtitle:"13:00-15:00"];
    [monday addChild:mSession1];
    [monday addChild:mSession2];
    [monday addChild:mSession3];
    var tuesday = [[Page alloc] initWithTitle:"Tuesday" andSubtitle:"Sessions on Tuesday"];
    var wednesday = [[Page alloc] initWithTitle:"Wednesday" andSubtitle:"Sessions on Wednesday"];
    var thursday = [[Page alloc] initWithTitle:"Thursday" andSubtitle:"Sessions on Thursday"];
    var friday = [[Page alloc] initWithTitle:"Friday" andSubtitle:"Sessions on Friday"];
    [rootPage addChild:monday];
    [rootPage addChild:tuesday];
    [rootPage addChild:wednesday];
    [rootPage addChild:thursday];
    [rootPage addChild:friday];
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
}

- (@action) load:(id)sender {
    console.log(@"loading...");
    var request = [CPURLRequest requestWithURL:baseURL];
    [request setHTTPMethod:'GET'];
    listConnection = [CPURLConnection connectionWithRequest:request delegate:self];
}

-(void)connection:(CPURLConnection)connection didReceiveData:(CPString)data {
    console.log(@"DATA: " + data);
    var obj = JSON.parse(data);
    console.log(@"obj: " + obj);
    console.log(@"obj[1].title: " + obj[1].title);
}
- (@action) save:(id)sender {
    console.log(@"saving...");
}


@end
