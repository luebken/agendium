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
    Page rootPage;
    @outlet CPTextField titleLabel;
    @outlet CPTextField idField;
    @outlet CPView pageView;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    [titleLabel setFont:[CPFont boldSystemFontOfSize:24.0]]; 
}

- (void)awakeFromCib
{
    rootPage = [[Page alloc] init];
    var monday = [[Page alloc] initWithTitle:"Monday" andSubtitle:"Sessions on Monday"];
    var tuesday = [[Page alloc] initWithTitle:"Tuesday" andSubtitle:"Sessions on Tuesday"];
    var wednesday = [[Page alloc] initWithTitle:"Wednesday" andSubtitle:"Sessions on Wednesday"];
    var thursday = [[Page alloc] initWithTitle:"Thursday" andSubtitle:"Sessions on Thursday"];
    var friday = [[Page alloc] initWithTitle:"Friday" andSubtitle:"Sessions on Friday"];
    [rootPage addChild:monday];
    [rootPage addChild:tuesday];
    [rootPage addChild:wednesday];
    [rootPage addChild:thursday];
    [rootPage addChild:friday];


    [box setBorderType:CPLineBorder]; 
    [box setBorderWidth:1]; 
    [box setBorderColor:[CPColor grayColor]];  

    var pageViewController = [[PageViewController alloc] initWithCibName:@"PageView"
                                                        bundle:nil];
    [pageViewController setPage:rootPage];
    [[pageViewController view] setFrame:CPRectMake(1,1,500, 350)]
    console.log('setPage');
    [pageView addSubview:[pageViewController view]];

    //[scrollView setDocumentView:[pageViewController view]];

    [saveButton setEnabled:NO];

    [idField becomeFirstResponder] 

    //[CPMenu setMenuBarVisible:YES];

}


//CPTextField Delegate
- (void)controlTextDidChange:(id)sender {
    var length = [[idField objectValue] length];
    [saveButton setEnabled:length > 0];
}

@end
