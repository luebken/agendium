
@import <Foundation/CPObject.j>
@import <AppKit/CPPanel.j>


@implementation IntroPanel : CPPanel
{
    id delegate;
    CPImageView imageView;    
}

- (id)initWithDelegate:(id) delegate2
{
    self = [self initWithContentRect:CGRectMake(100.0, 30.0, 490, 380) 
                            styleMask:CPHUDBackgroundWindowMask];

    if (self)
    {
        self.delegate = delegate2;
        [self setTitle:@"Welcome to Touchium"];
        [self setFloatingPanel:YES];
        
        var contentView = [self contentView],
            bounds = [contentView bounds];

        var titleLabel = [CPTextField labelWithTitle:"How to get started:"];
        [titleLabel setFont:[CPFont systemFontOfSize:14.0]];
        [titleLabel sizeToFit];
        [titleLabel setTextColor:[CPColor whiteColor]];
        [titleLabel setFrameOrigin:CGPointMake(5,5)];
        [contentView addSubview:titleLabel];
        
        var imageView = [[CPImageView alloc] initWithFrame:CGRectMake(5,25,475,325)];
        [imageView setImageScaling:CPScaleNone];
        [imageView setImage:[[CPImage alloc] initWithContentsOfFile:'Resources/intro4.png']];
        [contentView addSubview:imageView];
        

        var closeButton = [CPButton buttonWithTitle:"Close" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [closeButton setFrame:CGRectMake(220, 355, 70, 20)];
        [contentView addSubview:closeButton];
        [closeButton setTag:"introclose"];                
        [closeButton setTarget:self];
        [closeButton setAction:@selector(buttonAction:)];
    
    }

    return self;
}

- (void) buttonAction:(id) sender {
    if ([delegate respondsToSelector:@selector(panelDidClose:data:)]) {
         [delegate panelDidClose:[sender tag] data:undefined];
    }
    [self close];
}


@end