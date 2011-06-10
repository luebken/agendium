
@import <Foundation/CPObject.j>
@import <AppKit/CPPanel.j>


@implementation SelectLogoPanel : CPPanel
{
    id delegate @accessors;
    CPTextField field;
}

- (id)initWithUrl:(CPString)imgUrl andDelegate:(id) delegate2
{
    self = [self initWithContentRect:CGRectMake(200.0, 150.0, 330.0, 140.0) 
    styleMask:CPHUDBackgroundWindowMask];

    if (self)
    {
        self.delegate = delegate2;
        [self setTitle:@"Select Logo"];
        [self setFloatingPanel:YES];
        
        var contentView = [self contentView],
            bounds = [contentView bounds];

        var titleLabel = [CPTextField labelWithTitle:"Enter the URL of your mobile logo:"];
        [titleLabel setFont:[CPFont systemFontOfSize:14.0]];
        [titleLabel sizeToFit];
        [titleLabel setTextColor:[CPColor whiteColor]];
        [titleLabel setFrameOrigin:CGPointMake(45,5)];
        [contentView addSubview:titleLabel];

        field = [CPTextField textFieldWithStringValue:imgUrl placeholder:"" width:300];
        [field setFrameOrigin:CGPointMake(15,35)];
        [contentView addSubview:field];

        var loginButton = [CPButton buttonWithTitle:"Set" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [loginButton setFrame:CGRectMake(250,90, 70, 20)];
        [contentView addSubview:loginButton];
        [loginButton setTag:"setlogo"];
        [loginButton setTarget:self];
        [loginButton setAction:@selector(buttonAction:)];

        var cancelButton = [CPButton buttonWithTitle:"Cancel" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [cancelButton setFrame:CGRectMake(170,90, 70, 20)];
        [contentView addSubview:cancelButton];
        [cancelButton setTag:"cancellogo"];                
        [cancelButton setTarget:self];
        [cancelButton setAction:@selector(buttonAction:)];
    
    }

    return self;
}

- (void) buttonAction:(id) sender {
    if ([delegate respondsToSelector:@selector(panelDidClose:data:)]) {
         [delegate panelDidClose:[sender tag] data:[field objectValue]];
    }
    [self close];
}


@end