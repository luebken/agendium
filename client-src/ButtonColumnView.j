
@import <AppKit/CPView.j>


@implementation ButtonColumnView : CPView
{
    CPButton button;
    CPString row;
    id delegate;
}

- (id)initWithFrame:(CGRect)rect andDelegate:(id)delegate2  { 
        self = [super initWithFrame:rect]; 
        button = [CPButton buttonWithTitle:@">"]; 
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
    if(anObject.editing) {
        row = anObject.row;
        [button setTitle:"-"]; 
        [button setFrame:CGRectMake(0,0,24,24)];
        [button setCenter:CPPointMake(12,25)];         
    } else if(anObject.visible) {
        row = anObject.row;
        [button setTitle:">"];
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
        return self; 
} 

- (void)encodeWithCoder:(CPCoder)aCoder { 
        [super encodeWithCoder:aCoder]; 
        [aCoder encodeObject:button forKey:"button"]; 
}

- (void) rowSelected: (id)sender { 
    [[CPNotificationCenter defaultCenter] 
        postNotificationName:@"RowClickedNotification" 
        object:row];
}

//Bugfix / workaround for double click on "empty" row
- (void) setAction:(id)sender { }
- (void) setTarget:(id)sender { }

@end
