
@import <Foundation/CPObject.j>
@import "ButtonColumnView.j"
@import "CPPropertyAnimation.j"


@implementation PageViewController : CPViewController
{
    @outlet CPScrollView scrollView;
    Page page @accessors;
    @outlet CPButton addButton;
    @outlet CPButton backButton;
    @outlet CPButton editButton;
    @outlet CPPopUpButton itemtypeButton;

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
    [[column0 headerView] setStringValue:""];
    [column0 setWidth:70.0];
    [column0 setEditable:NO];
    [table addTableColumn:column0];
 
    var column1 = [[CPTableColumn alloc] initWithIdentifier:"first"];
    [[column1 headerView] setStringValue:"Title"];
    [column1 setWidth:170.0];
    [column1 setEditable:YES];
    [table addTableColumn:column1];

    var column2 = [[CPTableColumn alloc] initWithIdentifier:"second"]; 
    [[column2 headerView] setStringValue:@"Subtitle"];
    [column2 setWidth:230.0];
    [column2 setEditable:YES];
    [table addTableColumn:column2]; 

    var button = [[ButtonColumnView alloc] 
                    initWithFrame:CGRectMake(0.0, 0.0, 10.0, 20.0)
                    andDelegate:self];
    var column3 = [[CPTableColumn alloc] initWithIdentifier:"button"]; 
    [column3 setDataView:button];
    [column3 setWidth:30.0];
    [column3 setEditable:YES];
    [table addTableColumn:column3];

    [table setUsesAlternatingRowBackgroundColors:YES];
    [table setRowHeight:50];
    [table setDataSource:self];
    [table setDelegate:self];
    [table setAllowsColumnSelection:NO];
    
    [scrollView setDocumentView:table]; 

    [backButton setEnabled:NO];
    [itemtypeButton removeAllItems];

    editing = NO;

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


- (BOOL)tableView:(CPTableView)aTableView shouldEditTableColumn:(CPTableColumn)tableColumn row:(int)row
{
    [self setEditing:NO];//so switch always back to YES
    [self toggleEditing:aTableView];
    return YES;
}

- (@action) toggleEditing:(id)sender {
    var field;
    if(self.editing) {
        field = [CPTextField labelWithTitle:@""];
        //FIXME funktioniert nicht. custom cpview
        //[field setFrame:CGRectMake(10.0, 10.0, 100, 29.0)];
        //[field setAlignment:CPCenterTextAlignment];
        [field setVerticalAlignment:CPCenterTextAlignment];

        //[field setFont:[CPFont systemFontOfSize:14.0]];

        [self setEditing:NO];
        [editButton setTitle:@"Edit"];
        [editButton unsetThemeState:CPThemeStateDefault];

    } else {
        field = [CPTextField textFieldWithStringValue:@"" 
            placeholder:@"" 
              width:100];
        [self setEditing:YES];
        [editButton setTitle:@"Done"];
        [editButton setThemeState:CPThemeStateDefault];
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
        return [[[page attributes] allKeys] count];
    }
}

//table datasource method
- (id)tableView:(CPTableView)tableView
objectValueForTableColumn:(CPTableColumn)tableColumn
                    row:(int)row
{
    if([page isNavigationType]) {
        var pageAtRow = [[page children] objectAtIndex:row];
        if([[tableColumn identifier] isEqual:"zero"]) {
            return pageAtRow.type;
        } else if([[tableColumn identifier] isEqual:"first"]) {
            return [pageAtRow title];
        } else if([[tableColumn identifier] isEqual:"second"]) {
            return [pageAtRow subtitle];
        } else {
            var show = pageAtRow.type === 'Spacer' ? NO : YES;
            return {row:row, show:show, editing:editing};
        }
    } else {
        var key = [[page attributes] allKeys][row];
        var value = [[page attributes] objectForKey:key];
        if([[tableColumn identifier] isEqual:"zero"]) {
            return "";
        } else if([[tableColumn identifier] isEqual:"first"]) {
            return key;
        } else if([[tableColumn identifier] isEqual:"second"]) {
            return value;
        } else {
            return {show:NO, editing:editing}
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
        var col0 = [table tableColumns][0];
        var col1 = [table tableColumns][1]
        var oldAttributeKey = [self tableView:table objectValueForTableColumn:col0 row:row];
        var oldValue = [self tableView:table objectValueForTableColumn:col1 row:row];
        if([[tableColumn identifier] isEqual:"first"]) {
            [[page attributes] removeObjectForKey:oldAttributeKey];
            [[page attributes] setValue:oldValue forKey:aValue];
        } else {
            [[page attributes] setValue:aValue forKey:oldAttributeKey];
        }
    }
    //[table reloadData];
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
    if([page isNavigationType]) {
        var itemtype = [[itemtypeButton selectedItem] title];
        console.log('itemtype: ' + itemtype);
        var newpage;
        if(itemtype == 'Navigationpage') {
            newpage = [[Page alloc] initWithTitle:"The title of a subpage" 
                                      andSubtitle:"The optional subtitle of a subpage" 
                                          andType: "Navigation"];
        } else if(itemtype == 'Detailpage') {
            newpage = [[Page alloc] initWithTitle:"The title of a subpage" 
                                      andSubtitle:"The optional subtitle of a subpage" 
                                          andType: "Detail"];
        } else {
            newpage = [[Page alloc] initWithTitle:"A group title" 
                                          andSubtitle:"" 
                                              andType:"Spacer"];
        }
        [page addChild:newpage atIndex:[table selectedRow]];            
    } else {
        [[page attributes] setValue:"A value" forKey:"A attribute"];
    }
    [table reloadData];
}

- (void)deleteItemFromList:(id)row {
    if([page isNavigationType]) {
        [page removeChild:row];
    } else {
        var key = [[page attributes] allKeys][row];
        [[page attributes] removeObjectForKey:key];
    }
    [table deselectAll];
    [table reloadData];
    [self tableViewSelectionDidChange:null];
}


- (void) rowClicked:(id)notification {
    //FIXME remove/hide column 
    if(![self editing]) {
        var row = [notification object];
        page = [[page children] objectAtIndex:row];
    
        [[CPPropertyAnimation slideLeft:self view:scrollView] startAnimation];

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
    if(page.title) {
        title += " (" + page.type + ")";
    }

    [titleField setObjectValue:title];
    [itemtypeButton removeAllItems];
    var header1 = [[table tableColumns][1] headerView];
    var header2 = [[table tableColumns][2] headerView];
    if([page isNavigationType]) {
        [header1 setStringValue:@"Title"];
        [header2 setStringValue:@"Subtitle"];
        [itemtypeButton addItemsWithTitles: ['Navigationpage', 'Detailpage', 'Spacer']];
    } else {
        [header1 setStringValue:@"Attribute"];
        [header2 setStringValue:@"Value"];
        [itemtypeButton addItemsWithTitles: ['Attribute']];
    } 
    //[pagetypeButton selectItemWithTitle:page.type];
}

@end
