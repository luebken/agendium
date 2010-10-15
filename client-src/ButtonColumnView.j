
@import <AppKit/CPView.j>


@implementation ButtonColumnView : CPView
{
    CPButton button;
    CPString row;
    CPString column;
    id delegate;
    CPString normalTitle;
    CPString editingTitle;
}

- (id)initWithFrame:(CGRect)rect 
            andTitle:(CPString) normalTitle2 
            andEditingTitle: (CPString) editingTitle2
            andDelegate: (id) delegate2  { 
        self = [super initWithFrame:rect];
        
        
        self.editingTitle = editingTitle2; 
        self.normalTitle = normalTitle2; 
        
        button = [CPButton buttonWithTitle:normalTitle2]; 
        [button setFrame:CGRectMake(0,0,24,24)];
        [button setCenter:CPPointMake(12,25)];
        //[nameField setAutoresizingMask:CPViewWidthSizable | CPViewMaxYMargin]; 
        [button setAction:@selector(rowSelected:)];  
        
        [button setTarget:self];
        
        [self addSubview:button]; 
        self.delegate = delegate2;
        
        return self; 
}   

- (void)setObjectValue:(Object)anObject {
    column = anObject.column;
      
    if(anObject.editing) {
        row = anObject.row;
        [button setTitle:self.editingTitle]; 
        [button setFrame:CGRectMake(0,0,24,24)];
        [button setCenter:CPPointMake(12,25)];         
    } else if (anObject.visible) {
        row = anObject.row;
        [button setTitle:self.normalTitle];
        [button setFrame:CGRectMake(0,0,24,24)];
        [button setCenter:CPPointMake(12,25)]; 
    } else {
        row = -1;
        [button setFrame:CGRectMakeZero()];
    }
} 

- (id)initWithCoder:(CPCoder)aCoder { 
        self = [super initWithCoder:aCoder]; 
        button = [aCoder decodeObjectForKey:"button"]; 
        normalTitle = [aCoder decodeObjectForKey:"normalTitle"]; 
        editingTitle = [aCoder decodeObjectForKey:"editingTitle"]; 
        return self; 
} 

- (void)encodeWithCoder:(CPCoder)aCoder { 
        [super encodeWithCoder:aCoder]; 
        [aCoder encodeObject:button forKey:"button"]; 
        [aCoder encodeObject:normalTitle forKey:"normalTitle"]; 
        [aCoder encodeObject:editingTitle forKey:"editingTitle"]; 
}

- (void) rowSelected: (id)sender { 
    [[CPNotificationCenter defaultCenter] 
        postNotificationName:@"RowClickedNotification" 
        object: JSON.stringify({row:row, column:column})];
}

//Bugfix / workaround for double click on "empty" row
- (void) setAction:(id)sender { }
- (void) setTarget:(id)sender { }

@end
