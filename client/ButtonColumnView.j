
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
        [button setCenter:CPPointMake(10, 25)]; 
        //[nameField setAutoresizingMask:CPViewWidthSizable | CPViewMaxYMargin]; 
        [self addSubview:button]; 
        [button setTarget:self];
        [button setAction:@selector(rowSelected:)];  
        self.delegate = delegate2;
        return self; 
}   

- (void)setObjectValue:(Object)anObject { 
    row = anObject;
    [button setTitle:">"]; 
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
@end
