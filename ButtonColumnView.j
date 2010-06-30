
@import <AppKit/CPView.j>


@implementation ButtonColumnView : CPView
{
    CPButton button;
    CPString row;
}

- (id)initWithFrame:(CGRect)rect { 
        self = [super initWithFrame:rect]; 
        button = [CPButton buttonWithTitle:@">"]; 
        [button setCenter:CPPointMake(10, 25)]; 
        //[nameField setAutoresizingMask:CPViewWidthSizable | CPViewMaxYMargin]; 
        [self addSubview:button]; 
        [button setTarget:self];
        [button setAction:@selector(actionHandler:)];  

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

- (void) actionHandler: (id)sender { 
    console.log("handled "  + row); 
}
@end
