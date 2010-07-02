
@import <AppKit/CPView.j>


@implementation PageView : CPView
{
}

- (id)initWithFrame:(CGRect)aRect
{
    if (self = [super initWithFrame:aRect])
    {
        console.log('PageView.initWithFrame');
        
    }
    return self;
}

/*
- (void)drawRect:(CGRect)aRect
{
    // Add drawing code here
}
*/

/*
- (void)layoutSubviews
{
    // Add layout code here
}
*/

@end
