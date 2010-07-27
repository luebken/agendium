
@import <AppKit/CPView.j>


@implementation TextFieldColumnView : CPView
{
    CPTextField field;
}

- (id)initWithFrame:(CGRect)rect andTable:(id)table  { 
    self = [super initWithFrame:rect]; 
    field = [CPTextField textFieldWithStringValue:@"" 
                       placeholder:@"" 
                            width:100];
    [field setEditable:NO];
    [field setBordered:NO];
    [field setBezeled:NO];
    [field setDelegate:self];
    
    [field setFrame:CGRectMake(5,9,10,26)];
    [field setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable | CPViewMaxYMargin | CPViewMinYMargin]; 
    [self addSubview:field]; 
    
    [field setTarget:table];
    [field setAction:@selector(_commitDataViewObjectValue:)];
    return self; 
}


//a custom object containing information about visibility and the data
- (void)setObjectValue:(Object)value { 
    if(!value.visible) {
        [field setStringValue:""];
        [field setEditable:NO];
        [field setBordered:NO];
        [field setBezeled:NO];
        [field setAutoresizingMask:CPViewWidthSizable]; 
    } else {
        [field setAutoresizingMask:CPViewWidthSizable]; 
        [field setStringValue:value.title];
        [field setEditable:value.editing];
        [field setBordered:value.editing];
        [field setBezeled:value.editing];  
    }
    
}


- (id)initWithCoder:(CPCoder)aCoder { 
    self = [super initWithCoder:aCoder]; 
    field = [aCoder decodeObjectForKey:"field"]; 
    return self; 
} 

- (void)encodeWithCoder:(CPCoder)aCoder { 
    [super encodeWithCoder:aCoder]; 
    [aCoder encodeObject:field forKey:"field"]; 
}

//get called when editing starts
- (void) setAction:(id)sender { 
    console.log('setAction sender ' + sender);
    [field setAction:sender];
}
- (void) setTarget:(id)sender { 
    console.log('setTarget sender ' + sender);
    [field setTarget:sender];
}


@end
