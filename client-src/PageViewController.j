
@import <Foundation/CPObject.j>
@import "LPKit/LPSlideView.j"
@import "TMTableView.j"


@implementation PageViewController : CPViewController
{
    @outlet CPScrollView scrollView;
    Page page @accessors;
    @outlet CPButton addButton;
    @outlet CPButton backButton;
    @outlet CPButton editButton;
    @outlet CPPopUpButton itemtypeButton;
    id delegate;
    TMTableView table;
    @outlet CPTextField titleField;
    @outlet LPSlideView slideView;

    boolean editing @accessors;
}

- (void) initTable {
      table = [[TMTableView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 650.0)];
      [table setDataSource:self];
      [table setDelegate:self];
}

- (void) awakeFromCib {    
    [self initTable];
    [scrollView setDocumentView:table]; 

    [backButton setEnabled:NO];
    [itemtypeButton removeAllItems];

    editing = NO;

    [titleField setFont:[CPFont systemFontOfSize:14.0]];
    [titleField setValue:CPCenterTextAlignment forThemeAttribute:@"alignment"];

    //See ButtonColumnView
    [[CPNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(rowClicked:)
               name:@"RowClickedNotification"
             object:nil];
}

- (void) setDelegate:(id)delegate2 {
    delegate = delegate2;
}

//CPTableViewDelegate
- (BOOL)tableView:(CPTableView)aTableView shouldEditTableColumn:(CPTableColumn)tableColumn row:(int)row
{
    [self setEditing:NO];//so switch always back to YES in toggleEditing
    [self toggleEditing:aTableView];
    return YES;
}

- (@action) toggleEditing:(id)sender {
    var field;
    if(self.editing) {
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
        [self setEditing:YES];
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
        if([[tableColumn identifier] isEqual:"zero"]) {
            return pageAtRow.type;
        } else if([[tableColumn identifier] isEqual:"first"]) {
            //return {title: [pageAtRow title], row:row, visible:visible, type:pageAtRow.type, editing:editing};
            return [pageAtRow title];
        } else if([[tableColumn identifier] isEqual:"second"]) {
            visible = pageAtRow.type !== 'Group';
            //return {title: [pageAtRow subtitle], row:row, visible:visible, type:pageAtRow.type, editing:editing};
            return [pageAtRow subtitle];
        } else if([[tableColumn identifier] isEqual:"button2"]) {
            visible = pageAtRow.type !== 'Group' && editing;
            //return {title: [pageAtRow subtitle], row:row, visible:visible, type:pageAtRow.type, editing:editing};
            return {row:row, visible:visible, editing:editing, column:[tableColumn identifier]};
        } else {
            visible = pageAtRow.type !== 'Group';
            return {row:row, visible:visible, editing:editing, column:[tableColumn identifier]};
        }
    } else {
        var attribute = [[page attributes] objectAtIndex:row];
        var key = attribute.key;
        var value = attribute.value;
        if([[tableColumn identifier] isEqual:"zero"]) {
            return "Text";
        } else if([[tableColumn identifier] isEqual:"first"]) {
            //return {title: key, row:row, visible:YES, editing:editing};
            return key;
        } else if([[tableColumn identifier] isEqual:"second"]) {
            //return {title: value, row:row, visible:YES, editing:editing};
            return value;
        } else {
            return {visible:NO, row:row, editing:editing, column:[tableColumn identifier]};
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
            newpage = [[Page alloc] initWithTitle:"The title of a subpage" 
                                      andSubtitle:"The optional subtitle of a subpage" 
                                          andType: "Navigation"
                                  andNavigationId: navigationId ];
        } else if(itemtype == 'Detailpage') {
            newpage = [[Page alloc] initWithTitle:"The title of a subpage" 
                                      andSubtitle:"The optional subtitle of a subpage" 
                                          andType: "Detail"
                                  andNavigationId: navigationId];
        } else {
            newpage = [[Page alloc] initWithTitle:"A group title" 
                                          andSubtitle:"" 
                                              andType:"Group"
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
    
    if(![self editing]) {
        var oldpageid = page.navigationId;
        page = [[page children] objectAtIndex:row];
        var bounds = [[slideView subviews][0] bounds];
        var newScrollView =[[CPScrollView alloc] initWithFrame:bounds];
        [self initTable];
        [newScrollView setDocumentView:table]; 
        [slideView addSubview:newScrollView];
        [slideView slideToView:newScrollView];
        [self myRefresh];
        [delegate changePage:oldpageid to:page.navigationId reverse:NO];        
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
    CPLog("animationDidEnd");
}

- (@action)backButtonClicked:(id)sender {
    var oldpageid = page.navigationId;
    page = [page ancestor];
    var bounds = [[slideView subviews][0] bounds];
    var newScrollView =[[CPScrollView alloc] initWithFrame:bounds];
    [self initTable];
    [newScrollView setDocumentView:table]; 
    [slideView addSubview:newScrollView];
    [slideView slideToView:newScrollView direction:LPSlideViewNegativeDirection];
    [delegate changePage:oldpageid to:page.navigationId reverse:YES];        
    [self myRefresh];
}

- (void) myRefresh {
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
