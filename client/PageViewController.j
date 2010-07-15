
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


- (void) rowClicked:(id)notification {
    var row = [notification object];
    page = [[page children] objectAtIndex:row];
    [self myRefresh];
    //[table removeFromSuperview]
}

- (@action)backButtonClicked:(id)sender {
    page = [page ancestor];
    [self myRefresh];
}

- (@action) pageTypeClicked:(id)sender {
    var title = [[sender selectedItem] title];
    page.type = title;
    if(title == "List") {
        console.log('Selected Pagetype: List');
        [scrollView setDocumentView:table]; 
    } 
    if(title == "Detail") {
        console.log('Selected Pagetype: Detail');
        var imageView = [[CPImageView alloc] initWithFrame:CGRectMake(0,0,500,500)];    
        [imageView setBackgroundColor:[CPColor redColor]]; 
        [scrollView setDocumentView:imageView]; 
    } 
    [self myRefresh];
}

- (void) myRefresh {
    [table reloadData];
    [backButton setEnabled:page.ancestor != null];
    [addButton setEnabled:page.type == 'List'];
    var color = page.type == 'List' ? [CPColor blackColor] : [CPColor grayColor]; 
    [itemsLabel setTextColor:color];

    [table deselectAll];
    var title = page.title;
    if(page.subtitle != null) {
        title += " (" + page.subtitle + ")";
    }
    [titleField setObjectValue:title];
}

@end
