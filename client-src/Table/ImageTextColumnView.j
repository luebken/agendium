
@import <AppKit/CPView.j>


@implementation ImageTextColumnView : CPView
{
    CPTextField textfield;
    CPImageView imageView;    
}
- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    imageView = [[CPImageView alloc] initWithFrame:CGRectMake(2,2,22,22)];
    [imageView setImageScaling:CPScaleNone];
	
    textfield = [CPTextField labelWithTitle:@""];
    [textfield setFrame:CGRectMake(0,20,10,26)];
    [textfield setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable | CPViewMaxYMargin | CPViewMinYMargin];
    [textfield setTextColor:[CPColor grayColor]];
    
    [self addSubview:imageView]; 
    [self addSubview:textfield]; 
    
    return self;
}

- (void)setObjectValue:(Object)value { 
    [textfield setObjectValue:value];    
    var file;
    if(value == 'Navigation'){
        file = @"Resources/navigation.png"; 
    }else if(value == 'Group'){
        file = @"Resources/group2.png"; 
    }else if(value == 'Text'){
        file = @"Resources/text2.png"; 
    }else {
        file = @"Resources/detail2.png"; 
    }
    [imageView setImage:[[CPImage alloc] initWithContentsOfFile:file]];
}


- (id)initWithCoder:(CPCoder)aCoder { 
    self = [super initWithCoder:aCoder]; 
    textfield = [aCoder decodeObjectForKey:"textfield"]; 
    imageView = [aCoder decodeObjectForKey:"imageView"]; 
    return self; 
} 
- (void)encodeWithCoder:(CPCoder)aCoder { 
    [super encodeWithCoder:aCoder]; 
    [aCoder encodeObject:textfield forKey:"textfield"]; 
    [aCoder encodeObject:imageView forKey:"imageView"]; 
    
}


@end
