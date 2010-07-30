
@import <AppKit/CPView.j>


@implementation TextFieldColumnView : CPTextField
{
}
- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    [self setLineBreakMode:CPLineBreakByTruncatingTail];
    [self setValue:[CPColor colorWithHexString:@"333333"] forThemeAttribute:@"text-color"];
    [self setValue:[CPColor whiteColor] forThemeAttribute:@"text-color" inState:CPThemeStateSelected];
    [self setValue:[CPFont boldSystemFontOfSize:12] forThemeAttribute:@"font" inState:CPThemeStateSelected];
    [self setValue:CPCenterVerticalTextAlignment forThemeAttribute:@"vertical-alignment"];
    
    return self;
}

- (void)setObjectValue:(Object)value { 
    var s = value ? value.title : "";
    [super setObjectValue:s];
    /*
    if(!value.visible) {
        [self setEditable:NO];
        [self setBordered:NO];
        [self setBezeled:NO];
        [self setAutoresizingMask:CPViewWidthSizable]; 
    } else {
        [self setAutoresizingMask:CPViewWidthSizable]; 
        [self setEditable:value.editing];
        [self setBordered:value.editing];
        [self setBezeled:value.editing];  
    }
    */
}


@end
