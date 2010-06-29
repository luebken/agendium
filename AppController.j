/*
 * AppController.j
 * test2
 *
 * Created by You on May 26, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "Page.j"
@import "ButtonColumn.j"

@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    @outlet CPScrollView scrollView;
    CPTableView table;
    @outlet CPBox box;
    @outlet CPButton deleteButton;
    @outlet CPButton saveButton;
    CPArray rootPages;
    @outlet CPTextField titleLabel;
    @outlet CPTextField idField;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    [titleLabel setFont:[CPFont boldSystemFontOfSize:24.0]]; 
}

- (void)awakeFromCib
{
    rootPages = [[CPArray alloc] init];
    rootPages[0] = [[Page alloc] initWithTitle:"Monday" andSubtitle:"Sessions on Monday"];
    rootPages[1] = [[Page alloc] initWithTitle:"Tuesday" andSubtitle:"Sessions on Tuesday"];
    rootPages[2] = [[Page alloc] initWithTitle:"Wednesday" andSubtitle:"Sessions on Wednesday"];
    rootPages[3] = [[Page alloc] initWithTitle:"Thursday" andSubtitle:"Sessions on Thursday"];
    rootPages[4] = [[Page alloc] initWithTitle:"Friday" andSubtitle:"Sessions on Friday"];

    [box setBorderType:CPLineBorder]; 
    [box setBorderWidth:1]; 
    [box setBorderColor:[CPColor grayColor]]; 

    var table = [[CPTableView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 500.0)];
    [scrollView setDocumentView:table];

 
    var column1 = [[CPTableColumn alloc] initWithIdentifier:"title"];
    [[column1 headerView] setStringValue:"Title"];
    [column1 setWidth:200.0];
    [column1 setEditable:YES];
    [table addTableColumn:column1];

    var column2 = [[CPTableColumn alloc] initWithIdentifier:"subtitle"]; 
    [[column2 headerView] setStringValue:@"Subtitle"];
    [column2 setWidth:280.0];

    [column2 setEditable:YES];

    [table addTableColumn:column2]; 

    [table setUsesAlternatingRowBackgroundColors:YES];
    [table setRowHeight:50];
    [table setDataSource:self];
    [table setDelegate:self];
    [table setAllowsColumnSelection:YES];

    [deleteButton setEnabled:NO];
    [saveButton setEnabled:NO];


    [[CPNotificationCenter defaultCenter]
        addObserver:self
           selector:@selector(tableViewSelectionDidChange:)
               name:CPTableViewSelectionDidChangeNotification
             object:nil];

    //[CPMenu setMenuBarVisible:YES];

}

- (BOOL)tableView:(CPTableView)aTableView shouldEditTableColumn:(CPTableColumn)tableColumn row:(int)row
{
    console.log('shouldEditTableColumn');
    return YES;
}

- (int)numberOfRowsInTableView:(CPTableView)tableView
{
    return [rootPages count];
}

- (id)tableView:(CPTableView)tableView
objectValueForTableColumn:(CPTableColumn)tableColumn
                    row:(int)row
{
    var page = [rootPages objectAtIndex:row];
    if([[tableColumn identifier] isEqual:"title"]) {
        return [page title];
    } else {
        return [page subtitle];
    }
}

- (void)tableView:(CPTableView)aTableView 
    setObjectValue:(id)aValue 
    forTableColumn:(CPTableColumn)tableColumn 
               row:(int)row
{
    var page = [rootPages objectAtIndex:row];
    if([[tableColumn identifier] isEqual:"title"]) {
        [page setTitle:aValue];
    } else {
        [page setSubtitle:aValue];
    }
    //[table reloadData];

    //[table setSelectedRow:0];
    //var textfield = [tableColumn dataView];
    //[textfield setSelectedRange:CPMakeRange(0, 0)];
    //console.log('dataview ' + [tableColumn dataView]);
}

- (void)tableViewSelectionDidChange:(CPNotification)notification
{    
    var chosenRow = [[table selectedRowIndexes] firstIndex];
    [deleteButton setEnabled:chosenRow > -1]
}

- (@action)addItemToList:(id)sender {
    var newpage = [[Page alloc] initWithTitle:"A title" andSubtitle:"A subtitle"];
    [rootPages addObject:newpage];
    [table reloadData];
}

- (@action)appIdEntered:(id)sender {
    var length = [[idField objectValue] length];
    [saveButton setEnabled:length > 0];
}

- (@action)deleteItemFromList:(id)sender {
    [rootPages removeObjectAtIndex:[table selectedRow]];
    [table deselectAll];
    [table reloadData];
    [self tableViewSelectionDidChange:null];
}

@end
