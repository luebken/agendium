
@import <Foundation/CPObject.j>
@import "ButtonColumnView.j"


@implementation PageViewController : CPViewController
{
    @outlet CPScrollView scrollView;
    Page page @accessors;
    @outlet CPButton deleteButton;
    @outlet CPButton backButton;
    CPTableView table;
    @outlet CPTextField titleField;
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
    table = [[CPTableView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 500.0)];
 
    var column1 = [[CPTableColumn alloc] initWithIdentifier:"title"];
    [[column1 headerView] setStringValue:"Title"];
    [column1 setWidth:200.0];
    [column1 setEditable:YES];
    [table addTableColumn:column1];

    var column2 = [[CPTableColumn alloc] initWithIdentifier:"subtitle"]; 
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
    [table setAllowsColumnSelection:YES];
    
    [scrollView setDocumentView:table]; 

    [deleteButton setEnabled:NO];
    [backButton setEnabled:NO];

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

/*
- (BOOL)tableView:(CPTableView)aTableView shouldEditTableColumn:(CPTableColumn)tableColumn row:(int)row
{
    return YES;
}
*/
//table datasource method
- (int)numberOfRowsInTableView:(CPTableView)tableView
{
    return [[page children] count];
}

//table datasource method
- (id)tableView:(CPTableView)tableView
objectValueForTableColumn:(CPTableColumn)tableColumn
                    row:(int)row
{
    var pageAtRow = [[page children] objectAtIndex:row];
    if([[tableColumn identifier] isEqual:"title"]) {
        return [pageAtRow title];
    } else if([[tableColumn identifier] isEqual:"subtitle"]) {
        return [pageAtRow subtitle];
    } else {
        return row + "";
    }
}

- (void)tableView:(CPTableView)aTableView 
    setObjectValue:(id)aValue 
    forTableColumn:(CPTableColumn)tableColumn 
               row:(int)row
{
    var pageAtRow = [[page children] objectAtIndex:row];
    if([[tableColumn identifier] isEqual:"title"]) {
        [pageAtRow setTitle:aValue];
    } else {
        [pageAtRow setSubtitle:aValue];
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
    var newpage = [[Page alloc] initWithTitle:"A title" andSubtitle:"A subtitle"];
    [page addChild:newpage];
    [table reloadData];
}

- (@action)deleteItemFromList:(id)sender {
    [page removeChild:[table selectedRow]];
    [table deselectAll];
    [table reloadData];
    [self tableViewSelectionDidChange:null];
}


//CPTextField Delegate
- (void)controlTextDidChange:(id)sender {
    var length = [[titleField objectValue] length];
    [page setTitle:[titleField objectValue]];
    [[CPNotificationCenter defaultCenter] 
        postNotificationName:@"PageChangedNotification" 
        object:page]; 
}

- (void) rowClicked:(id)notification {
    var row = [notification object];
    page = [[page children] objectAtIndex:row];
    [table reloadData];
    [backButton setEnabled:page.ancestor != null];
    [table deselectAll];

    //[table removeFromSuperview]
}

- (@action)backButtonClicked:(id)sender {
    page = [page ancestor];
    [table reloadData];
    [backButton setEnabled:page.ancestor != null];
    [table deselectAll];
}


@end
