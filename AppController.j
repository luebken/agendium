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
@import "TextfieldView.j"


@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    @outlet CPTableView table;
    @outlet CPBox box;
    CPArray rootPages;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
    console.log("applicationDidFinishLaunching");
}

- (void)awakeFromCib
{
    console.log("awakeFromCib:");

    rootPages = [[CPArray alloc] init];
    rootPages[0] = [[Page alloc] initWithTitle:"A new Page"];
    rootPages[1] = [[Page alloc] initWithTitle:"A second Page"];

    [box setBorderType:CPLineBorder]; 
    [box setBorderWidth:1]; 
    [box setBorderColor:[CPColor grayColor]]; 

 
    var column1 = [[CPTableColumn alloc] init];
    [column1 setWidth:350.0];
    [column1 setIdentifier:1];
    [table addTableColumn:column1];
    console.log('dataview:'+ [[column1 dataView] isEditable]);
    [column1 setEditable:YES];

    var column2 = [[CPTableColumn alloc] init]; 
    var textfield = [[TextfieldView alloc] init];
    [column2 setDataView:textfield];
    //[button setTarget:self]; 
    //[button setAction:@selector(deleteItemFromList:)]; 
    [table addTableColumn:column2]; 


    [table setUsesAlternatingRowBackgroundColors:YES];
    [table setRowHeight:50];
    [table setDataSource:self];
    [table setDelegate:self];
    [table setAllowsColumnSelection:YES];



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
    console.log(" [rootPages objectAtIndex:"+row+"] " +  [rootPages objectAtIndex:row])
//    if([[tableColumn identifier] isEqual:1]) {
        return [rootPages objectAtIndex:row];
//    }
}
- (@action)addItemToList:(id)sender {
    [rootPages addObject:[[Page alloc] initWithTitle:"A new Page"]];
    [table reloadData];
}

- (@action)deleteItemFromList:(id)sender {
    console.log("delete " + [table selectedRow]);
}

@end
