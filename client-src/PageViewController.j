
@import <Foundation/CPObject.j>
@import "ButtonColumnView.j"
@import "CPPropertyAnimation.j"
@import "ImageTextColumnView.j"


@implementation PageViewController : CPViewController
{
    @outlet CPScrollView scrollView;
    Page page @accessors;
    @outlet CPButton addButton;
    @outlet CPButton backButton;
    @outlet CPButton editButton;
    @outlet CPPopUpButton itemtypeButton;
    id delegate;
    CPTableView table;
    @outlet CPTextField titleField;

    boolean editing @accessors;
}
- (id) initWithCibName: (CPString) aCibNameOrNil
                bundle: (CPBundle) aCibBundleOrNil
{
    if (self = [super initWithCibName:aCibNameOrNil bundle:aCibBundleOrNil])
    {
        //console.log('PageViewController1 :' + scrollView);  

    }
    return self;
}
- (void) awakeFromCib {    
    table = [[CPTableView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 650.0)];
 
    var column0 = [[CPTableColumn alloc] initWithIdentifier:"zero"];
    var imageColumn = [[ImageTextColumnView alloc] 
                    initWithFrame:CGRectMake(0.0, 0.0, 20.0, 30.0)];
    [column0 setDataView:imageColumn];
    [[column0 headerView] setStringValue:""];    
    [column0 setWidth:75.0];
    [column0 setEditable:NO];
    [table addTableColumn:column0];
 
    var column1 = [[CPTableColumn alloc] initWithIdentifier:"first"];
    [[column1 headerView] setStringValue:"Title"];
    var field = [CPTextField labelWithTitle:@""];
    [field setFont:[CPFont systemFontOfSize:14.0]];
    [field setVerticalAlignment:CPCenterTextAlignment];
    [column1 setDataView:field];
        
    //var fieldColumn = [[TextFieldColumnView alloc] 
    //                initWithFrame:CGRectMake(0.0, 0.0, 20.0, 30.0)];
    //[column1 setDataView:fieldColumn];
    [column1 setWidth:170.0];
    [column1 setEditable:YES];
    [table addTableColumn:column1];

    var column2 = [[CPTableColumn alloc] initWithIdentifier:"second"]; 
    //[column2 setDataView:fieldColumn];
    [[column2 headerView] setStringValue:@"Subtitle"];
    [column2 setWidth:230.0];
    [column2 setEditable:YES];
    [column2 setDataView:field];
    
    [table addTableColumn:column2]; 

    var buttonColumn = [[ButtonColumnView alloc] 
                    initWithFrame:CGRectMake(0.0, 0.0, 10.0, 20.0)
                    andDelegate:self];
    var column3 = [[CPTableColumn alloc] initWithIdentifier:"button"]; 
    [column3 setDataView:buttonColumn];
    [column3 setWidth:30.0];
    [column3 setEditable:YES];
    [table addTableColumn:column3];

    [table setUsesAlternatingRowBackgroundColors:YES];
    [table setAlternatingRowBackgroundColors:[[CPColor whiteColor], [CPColor colorWithHexString:@"e4e7ff"]]];
    
    [table setRowHeight:50];
    [table setDataSource:self];
    [table setDelegate:self];
    [table setAllowsColumnSelection:NO];
    
    [scrollView setDocumentView:table]; 

    [backButton setEnabled:NO];
    [itemtypeButton removeAllItems];

    editing = NO;

    [titleField setFont:[CPFont systemFontOfSize:14.0]];
    [titleField setValue:CPCenterTextAlignment forThemeAttribute:@"alignment"];


/*
    [[CPNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(tableViewSelectionDidChange:)
               name:CPTableViewSelectionDidChangeNotification
             object:nil];
*/

    [[CPNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(rowClicked:)
               name:@"RowClickedNotification"
             object:nil];
             
    /*
    [addButton setTheme:nil];
    var plusImg = [[CPImage alloc] initWithContentsOfFile:@"Resources/plus.png"]; 
    [addButton setImage:plusImg]; 
    var plusAltImage = [[CPImage alloc] initWithContentsOfFile:@"Resources/plus_down.png"]; 
    [addButton setAlternateImage: plusAltImage];     
    */
}

- (void) setDelegate:(id)delegate2 {
    delegate = delegate2;
}

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
            visible = pageAtRow.type !== 'Spacer';
            //return {title: [pageAtRow subtitle], row:row, visible:visible, type:pageAtRow.type, editing:editing};
            return [pageAtRow subtitle];
        } else {
            visible = pageAtRow.type !== 'Spacer';
            return {row:row, visible:visible, editing:editing};
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
            return {visible:NO, row:row, editing:editing};
        }
    }
}

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
    //[table setSelectedRow:0];
    //var textfield = [tableColumn dataView];
    //[textfield setSelectedRange:CPMakeRange(0, 0)];
}
- (id)tableView:(CPTableView)table2 isGroupRow:(id)row {
    console.log("isGroupRow:" + row);
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
    if(index < 0) index = page.children.length;

    if([page isNavigationType]) {
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
                                              andType:"Spacer"
                                      andNavigationId: navigationId ];
        }
        [page addChild:newpage atIndex:index];            
    } else {
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
    //[self tableViewSelectionDidChange:null];
}


- (void) rowClicked:(id)notification {
    //FIXME remove/hide column 
    if(![self editing]) {
        var row = [notification object];
        page = [[page children] objectAtIndex:row];
        [[CPPropertyAnimation slideLeft:self view:scrollView] startAnimation];
        [delegate selectedPage:page reverse:NO];
        [self myRefresh];
    } else {
        [self deleteItemFromList:[notification object]];
    }
    //[table removeFromSuperview]
}

-(void)animationDidEnd:(CPAnimation)animation {
    console.log("animationDidEnd");
}

- (@action)backButtonClicked:(id)sender {
    [[CPPropertyAnimation slideRight:self view:scrollView] startAnimation];
    page = [page ancestor];
    [delegate selectedPage:page reverse:YES];
    [self myRefresh];
}

- (void) myRefresh {
    [table reloadData];
    [backButton setEnabled:page.ancestor != null];
    //var color = [page isListType] ? [CPColor blackColor] : [CPColor grayColor]; 
    //[itemsLabel setTextColor:color];

    [table deselectAll];
    var title = page.title;
    if(page.subtitle != null) {
        title += " / " + page.subtitle;
    }
    if(!page.title) {
        title = "Untitled"    
    }
    if(![page isRootPage]) {
        title += " (" + page.type + ")";
    }


    [titleField setObjectValue:title];
    [itemtypeButton removeAllItems];
    var header0 = [[table tableColumns][0] headerView];
    var header1 = [[table tableColumns][1] headerView];
    var header2 = [[table tableColumns][2] headerView];
    [header0 setStringValue:@"Type"];
    if([page isNavigationType]) {
        [header1 setStringValue:@"Title"];
        [header2 setStringValue:@"Subtitle"];
        [itemtypeButton addItemsWithTitles: ['Navigationpage', 'Detailpage', 'Spacer']];
    } else {
        [header1 setStringValue:@"Attribute"];
        [header2 setStringValue:@"Value"];
        [itemtypeButton addItemsWithTitles: ['Text', 'Link', 'Tweeter']];
    } 
    //[pagetypeButton selectItemWithTitle:page.type];
}

@end
