@import <Foundation/CPObject.j>
@import "ButtonColumnView.j"
@import "ImageTextColumnView.j"

//Touchiums TableView
@implementation TMTableView : CPTableView
{
    
}

- (id)initWithFrame:(CGRect) frame {
    if(self = [super initWithFrame:frame]) {
        [self setUsesAlternatingRowBackgroundColors:YES];
        //[self setAlternatingRowBackgroundColors:[[CPColor whiteColor], [CPColor colorWithHexString:@"e4e7ff"]]];
        [self setRowHeight:50];
        [self setAllowsColumnSelection:NO];
        
        
        var column0 = [[CPTableColumn alloc] initWithIdentifier:"zero"];
        var imageColumn = [[ImageTextColumnView alloc] 
                        initWithFrame:CGRectMake(0.0, 0.0, 20.0, 30.0)];
        [column0 setDataView:imageColumn];
        [[column0 headerView] setStringValue:""];    
        [column0 setWidth:75.0];
        [column0 setEditable:NO];
        [self addTableColumn:column0];

        var column1 = [[CPTableColumn alloc] initWithIdentifier:"first"];
        [[column1 headerView] setStringValue:"Title"];
        var field = [CPTextField labelWithTitle:@""];
        [field setFont:[CPFont systemFontOfSize:14.0]];
        [field setTextColor:[CPColor colorWithHexString:@"333333"]];
        [field setTextShadowOffset:CGSizeMakeZero()];
        [field setVerticalAlignment:CPCenterTextAlignment];
        [field setLineBreakMode:CPLineBreakByWordWrapping];
        /*
        [field setSendsActionOnEndEditing:YES];
        [field setAction:@selector(didEndEditing)];  
        [[CPNotificationCenter defaultCenter]
            addObserver:self
               selector:@selector(didEndEditing:)
                   name:@"CPControlTextDidEndEditingNotification"
                 object:field];
        */
        
        
        [column1 setDataView:field];

        [column1 setWidth:170.0];
        [column1 setEditable:YES];
        [self addTableColumn:column1];

        var column2 = [[CPTableColumn alloc] initWithIdentifier:"second"]; 
        [[column2 headerView] setStringValue:@"Subtitle"];
        [column2 setWidth:230.0];
        [column2 setEditable:YES];
        [column2 setDataView:field];

        [self addTableColumn:column2]; 

        var buttonColumn = [[ButtonColumnView alloc] 
                        initWithFrame:CGRectMake(0.0, 0.0, 10.0, 20.0)
                        andTitle:"▶" andEditingTitle: "−"];
        var column3 = [[CPTableColumn alloc] initWithIdentifier:"button1"]; 
        [column3 setDataView:buttonColumn];
        [column3 setWidth:30.0];
        [column3 setEditable:YES];
        [self addTableColumn:column3];

        var buttonColumn2 = [[ButtonColumnView alloc] 
                        initWithFrame:CGRectMake(0.0, 0.0, 10.0, 20.0)
                        andTitle:"" andEditingTitle: "⏎"];
        var column4 = [[CPTableColumn alloc] initWithIdentifier:"button2"]; 
        [column4 setDataView:buttonColumn2];
        [column4 setWidth:30.0];
        [column4 setEditable:YES];
        [self addTableColumn:column4];

    }
    return self;
    
}
@end