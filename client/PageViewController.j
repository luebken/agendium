
@import <Foundation/CPObject.j>
@import "ButtonColumnView.j"


@implementation PageViewController : CPViewController
{
    @outlet CPScrollView scrollView;
    Page page @accessors;
    @outlet CPButton deleteButton;
    @outlet CPButton addButton;
    @outlet CPButton backButton;
    @outlet CPButton editButton;
    @outlet CPPopUpButton pagetypeButton;
    CPTableView table;
    @outlet CPTextField titleField;
    @outlet CPTextField itemsLabel;

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
    table = [[CPTableView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 600.0)];
 
    var column1 = [[CPTableColumn alloc] initWithIdentifier:"first"];
    [[column1 headerView] setStringValue:"Title"];
    [column1 setWidth:200.0];
    [column1 setEditable:YES];
    [table addTableColumn:column1];

    var column2 = [[CPTableColumn alloc] initWithIdentifier:"second"]; 
    [[column2 headerView] setStringValue:@"Subtitle"];
    [column2 setWidth:260.0];
    [column2 setEditable:YES];
    [table addTableColumn:column2]; 

    var button = [[ButtonColumnView alloc] 
                    initWithFrame:CGRectMake(0.0, 0.0, 10.0, 20.0)
                    andDelegate:self];
    var column3 = [[CPTableColumn alloc] initWithIdentifier:"button"]; 
    [column3 setDataView:button];
    [column3 setWidth:20.0];
    [column3 setEditable:YES];
    [table addTableColumn:column3];

    [table setUsesAlternatingRowBackgroundColors:YES];
    [table setRowHeight:50];
    [table setDataSource:self];
    [table setDelegate:self];
    [table setAllowsColumnSelection:NO];
    
    [scrollView setDocumentView:table]; 

    [deleteButton setEnabled:NO];
    [backButton setEnabled:NO];
    [pagetypeButton removeAllItems];
    [pagetypeButton addItemsWithTitles: ['List', 'Detail']];

    [[CPNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(tableViewSelectionDidChange:)
               name:CPTableViewSelectionDidChangeNotification
             object:nil];

    [[CPNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(rowClicked:)
               name:@"RowClickedNotification"
             object:nil];
}


- (BOOL)tableView:(CPTableView)aTableView shouldEditTableColumn:(CPTableColumn)tableColumn row:(int)row
{
    [self toggleEditing:aTableView];
    return self.editing;
}

- (@action) toggleEditing:(id)sender {
    var field;
    if(self.editing) {
        field = [CPTextField labelWithTitle:@""];
        [self setEditing:NO];
        [editButton setTitle:@"Edit"];
    } else {
        field = [CPTextField textFieldWithStringValue:@"" 
            placeholder:@"" 
                  width:100];
        [self setEditing:YES];
        [editButton setTitle:@"Done"];

    }
    var cols = [table tableColumns];
    [cols[0] setDataView:field];
    [cols[1] setDataView:field];

    [self myRefresh];
}


//table datasource method
- (int)numberOfRowsInTableView:(CPTableView)tableView
{
    if([page isListType]) {
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
    if([page isListType]) {
        var pageAtRow = [[page children] objectAtIndex:row];
        if([[tableColumn identifier] isEqual:"first"]) {
            return [pageAtRow title];
        } else if([[tableColumn identifier] isEqual:"second"]) {
            return [pageAtRow subtitle];
        } else {
            return row + "";
        }
    } else {
        var key = [[page attributes] allKeys][row];
        var value = [[page attributes] objectForKey:key];
        if([[tableColumn identifier] isEqual:"first"]) {
            return key;
        } else if([[tableColumn identifier] isEqual:"second"]) {
            return value;
        } 
    }
}

- (void)tableView:(CPTableView)aTableView 
    setObjectValue:(id)aValue 
    forTableColumn:(CPTableColumn)tableColumn 
               row:(int)row
{
    if([page isListType]) {
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
- (void)tableViewSelectionDidChange:(CPNotification)notification
{    
    var chosenRow = [[table selectedRowIndexes] firstIndex];
    [deleteButton setEnabled:chosenRow > -1]
}

- (@action)addItemToList:(id)sender {
    if([page isListType]) {
        var newpage = [[Page alloc] initWithTitle:"A title" andSubtitle:"A subtitle"];
        [page addChild:newpage];
    } else {
        [[page attributes] setValue:"A value" forKey:"A attribute"];
    }
    [table reloadData];
}

- (@action)deleteItemFromList:(id)sender {
    var row = [table selectedRow];
    if([page isListType]) {
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
    if([page isListType]) {
        var row = [notification object];
        page = [[page children] objectAtIndex:row];
        [self myRefresh];
    }
    //[table removeFromSuperview]
}

- (@action)backButtonClicked:(id)sender {
    page = [page ancestor];
    [self myRefresh];
}

- (@action) pageTypeClicked:(id)sender {
    var title = [[sender selectedItem] title];
    page.type = title;
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
        title += " (" + page.subtitle + ")";
    }
    [titleField setObjectValue:title];

    var header1 = [[table tableColumns][0] headerView];
    var header2 = [[table tableColumns][1] headerView];
    if([page isListType]) {
        [header1 setStringValue:@"Title"];
        [header2 setStringValue:@"Subtitle"];
    } else {
        [header1 setStringValue:@"Attribute"];
        [header2 setStringValue:@"Value"];
    } 
    [pagetypeButton selectItemWithTitle:page.type];
}

@end
