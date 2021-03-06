
@import <Foundation/CPObject.j>
@import "LPKit/LPSlideView.j"
@import "Table/TMTableView.j"
@import "Panels/SelectLogoPanel.j"

@implementation PageViewController : CPViewController
{
    @outlet CPScrollView scrollView;
    @outlet CPButton addButton;
    @outlet CPButton backButton;
    @outlet CPPopUpButton itemtypeButton;
    @outlet CPTextField titleField;
    @outlet LPSlideView slideView;

    id delegate;
    TMTableView table;
    Page page @accessors;
    boolean myediting @accessors;
}

- (void) initTable {
      self.table = [[TMTableView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 650.0)];
      [table setDataSource:self];
      [table setDelegate:self];
}

- (void) awakeFromCib {    
    [self initTable];
    [scrollView setDocumentView:table]; 

    [backButton setEnabled:NO];
    [itemtypeButton removeAllItems];

    self.myediting = NO;

    [titleField setFont:[CPFont systemFontOfSize:14.0]];
    [titleField setValue:CPCenterTextAlignment forThemeAttribute:@"alignment"];

    //See ButtonColumnView
    [[CPNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(rowClicked:)
               name:@"RowClickedNotification"
             object:nil];
}

- (void) setDelegate:(id)newDelegate {
    self.delegate = newDelegate;
}

//CPTableViewDelegate
- (BOOL)tableView:(CPTableView)aTableView shouldEditTableColumn:(CPTableColumn)tableColumn row:(int)row
{
    [self setMyediting:YES];
    //[self toggleEditing:aTableView];
    return YES;
}

/*
- (@action) toggleEditing:(id)sender {
    var field;
    if(self.myediting) {
        [self setEditing:NO];
        [editButton setTitle:@"Edit"];
        [editButton unsetThemeState:CPThemeStateDefault];
        field = [CPTextField labelWithTitle:@""];
        [field setFont:[CPFont systemFontOfSize:14.0]];
        [field setVerticalAlignment:CPCenterTextAlignment];
        [field setLineBreakMode:CPLineBreakByWordWrapping];
        [[CPNotificationCenter defaultCenter] 
            postNotificationName:@"EditingDoneNotification" 
            object:nil];
    } else {
        [self setMyediting:YES];
        [editButton setTitle:@"Done"];
        [editButton setThemeState:CPThemeStateDefault];
        field = [CPTextField textFieldWithStringValue:@"" 
                    placeholder:@"" 
                          width:100];
    }
    var cols = [table tableColumns];
    [cols[1] setDataView:field];
    [cols[2] setDataView:field];
    [self myRefresh];
}
*/


//table datasource method
- (int)numberOfRowsInTableView:(CPTableView)tableView
{
    if([page isNavigationType]) {
        return [[page children] count];
    } else {
        return [[page attributes] count];
    }
}

//table datasource method
- (id)tableView:(CPTableView)tableView
objectValueForTableColumn:(CPTableColumn)tableColumn
                    row:(int)row
{
    if([page isNavigationType]) {
        var pageAtRow = [[page children] objectAtIndex:row];
        var visible = YES; 
        switch([tableColumn identifier]){
            case "zero": 
              return pageAtRow.type;
            case "first":
              return pageAtRow.title;
            case "second":
              return pageAtRow.subtitle;
            case "button2":
              visible = pageAtRow.type !== 'Group' && myediting;
              return {row:row, visible:visible, editing:myediting, column:[tableColumn identifier]};
            default :
              visible = pageAtRow.type !== 'Group';
              return {row:row, visible:visible, editing:myediting, column:[tableColumn identifier]};   
        }
    } else {
        var attribute = [[page attributes] objectAtIndex:row];
        var key = attribute.key;
        var value = attribute.value;
        switch([tableColumn identifier]){
            case "zero": 
              return "Text";
            case "first":
              return key;
            case "second":
              return value;
            default :
              return {visible:NO, row:row, editing:myediting, column:[tableColumn identifier]};
        }
    }
}

//table datasource method
- (void)tableView:(CPTableView)aTableView 
    setObjectValue:(id)aValue 
    forTableColumn:(CPTableColumn)tableColumn 
               row:(int)row
{
    if([page isNavigationType]) {
        var pageAtRow = [[page children] objectAtIndex:row];        
        if([[tableColumn identifier] isEqual:"first"]) {
            [pageAtRow setTitle:aValue];
        } else {
            [pageAtRow setSubtitle:aValue];
        }
    } else {
        var attribute = [[page attributes] objectAtIndex:row];        
        if([[tableColumn identifier] isEqual:"first"]) {
            attribute.key = aValue;
        } else {
            attribute.value = aValue;
        }
    }
    [table reloadData];
}
- (id)tableView:(CPTableView)table2 isGroupRow:(id)row {
    return YES;
}

/*
- (void)tableViewSelectionDidChange:(CPNotification)notification
{    
    var chosenRow = [[table selectedRowIndexes] firstIndex];
}
*/

- (@action)addItemToList:(id)sender {    
    var index = [table selectedRow];

    if([page isNavigationType]) {
        if(index < 0) index = page.children.length;
        var itemtype = [[itemtypeButton selectedItem] title];
        var newpage;
        var navigationId = page.navigationId + "c" + index;
        if(itemtype == 'Navigationpage') {
            newpage = [[Page alloc] initWithTitle:"Title of a navigation page" 
                                      andSubtitle:"The optional subtitle" 
                                          andType: "Navigation"
                                       andLogourl: ''
                                         andColor: ''
                                  andNavigationId: navigationId ];
        } else if(itemtype == 'Detailpage') {
            newpage = [[Page alloc] initWithTitle:"Title of a detail page" 
                                      andSubtitle:"The optional subtitle" 
                                          andType: "Detail"
                                       andLogourl: ''
                                         andColor: ''
                                  andNavigationId: navigationId];
        } else {
            newpage = [[Page alloc] initWithTitle:"A group title" 
                                          andSubtitle:"" 
                                              andType:"Group"
                                           andLogourl: ''
                                             andColor: ''
                                      andNavigationId: navigationId ];
        }
        [page addChild:newpage atIndex:index];            
    } else {
        if(index < 0) index = page.attributes.length;
        var attribute = { key:"A key", value:"A value" };
        [[page attributes] insertObject:attribute atIndex:index];
    }
    
    [[CPNotificationCenter defaultCenter] 
        postNotificationName:@"AddItemToListNotification" 
        object:nil];
        
    [table reloadData];
}

- (void)deleteItemFromList:(id)row {
    if([page isNavigationType]) {
        [page removeChild:row];
    } else {
        [[page attributes] removeObjectAtIndex:row];
    }
    [table deselectAll];
    [table reloadData];
}

- (void)duplicateItemFromList:(id)row {
    if([page isNavigationType]) {
        [page duplicateChild:row];
    } else {
        //[[page attributes] removeObjectAtIndex:row];
    }
    [table deselectAll];
    [table reloadData];
}



- (void) rowClicked:(id)notification {
    var o = JSON.parse([notification object]); //workaround strange notification behaviour
    var row = o.row;
    var column = o.column;
    
    if(![self myediting]) {
        var oldpageid = page.navigationId;
        page = [[page children] objectAtIndex:row];
        var bounds = [[slideView subviews][0] bounds];
        var newScrollView =[[CPScrollView alloc] initWithFrame:bounds];
        [self initTable];
        [newScrollView setDocumentView:table]; 
        [slideView addSubview:newScrollView];
        [slideView slideToView:newScrollView];
        [self myRefresh];
        [delegate changePageTo:page.navigationId animate:YES reverse:NO];        
    } else {
        if(column === "button1"){
            [self deleteItemFromList:row];
        } else {
            [self duplicateItemFromList:row];            
        }
    }
    //[table removeFromSuperview]
}

-(void)animationDidEnd:(CPAnimation)animation {
}

//
// Actions
//

- (@action)backButtonClicked:(id)sender {
    var oldpageid = page.navigationId;
    page = [page ancestor];
    var bounds = [[slideView subviews][0] bounds];
    var newScrollView =[[CPScrollView alloc] initWithFrame:bounds];
    [self initTable];
    [newScrollView setDocumentView:table]; 
    [slideView addSubview:newScrollView];
    [slideView slideToView:newScrollView direction:LPSlideViewNegativeDirection];
    [delegate changePageTo:page.navigationId animate:YES reverse:YES];        
    [self myRefresh];
}

- (@action) selectLogo:(id)sender {
    [[[SelectLogoPanel alloc] initWithUrl:self.page.logourl andColor:self.page.color andDelegate:self] orderFront:nil];    
}

//Panel Delegate
- (void) panelDidClose:(id)tag data:(id)data {
    switch(tag){
        case "setlogo":
            self.page.logourl = data.logourl;
            self.page.color = data.color;
            break;
    } 
}

- (void) myRefresh {
    [self setMyediting:NO];
    [table reloadData];
    [backButton setEnabled:page.ancestor != null];
    [table deselectAll];
    
    var title = page.title;
    if(page.subtitle) title += " / " + page.subtitle;
    if(!page.title) title = "Untitled";
    if(![page isRootPage]) title += " (" + page.type + ")";

    [titleField setObjectValue:title];
    var oldtype = [[itemtypeButton selectedItem] title];
    [itemtypeButton removeAllItems];
    var header0 = [[table tableColumns][0] headerView];
    var header1 = [[table tableColumns][1] headerView];
    var header2 = [[table tableColumns][2] headerView];
    var types;
    [header0 setStringValue:@"Type"];
    if([page isNavigationType]) {
        [header1 setStringValue:@"Title"];
        [header2 setStringValue:@"Subtitle"];
        types = ['Navigationpage', 'Detailpage', 'Group'];
    } else {
        [header1 setStringValue:@"Attribute"];
        [header2 setStringValue:@"Value"];
        types = ['Text'];//, 'Link', 'Tweeter']];
    } 
    [itemtypeButton addItemsWithTitles: types];
    if([types containsObject:oldtype]) {
        [itemtypeButton selectItemWithTitle:oldtype];        
    }
}

@end
