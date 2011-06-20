
@import <Foundation/CPObject.j>
@import <AppKit/CPPanel.j>


@implementation SelectLogoPanel : CPPanel
{
    id delegate @accessors;
    CPTextField logofield;
    CPTextField colorfield;
}

- (id)initWithUrl:(CPString)imgUrl 
         andColor:(CPString)color
      andDelegate:(id) delegate2
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

        var titleLabel = [CPTextField labelWithTitle:"Logo URL:"];
        [titleLabel setTextColor:[CPColor whiteColor]];
        [titleLabel setFrameOrigin:CGPointMake(25,30)];
        [contentView addSubview:titleLabel];

        logofield = [CPTextField textFieldWithStringValue:imgUrl placeholder:"" width:200];
        [logofield setFrameOrigin:CGPointMake(100,25)];
        [contentView addSubview:logofield];
        
        var colorLabel = [CPTextField labelWithTitle:"Color:"];
        [colorLabel setTextColor:[CPColor whiteColor]];
        [colorLabel setFrameOrigin:CGPointMake(25,60)];
        [contentView addSubview:colorLabel];

        colorfield = [CPTextField textFieldWithStringValue:color placeholder:"" width:120];
        [colorfield setFrameOrigin:CGPointMake(100,55)];
        [contentView addSubview:colorfield];

        var loginButton = [CPButton buttonWithTitle:"Set" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [loginButton setFrame:CGRectMake(250, 100, 70, 20)];
        [contentView addSubview:loginButton];
        [loginButton setTag:"setlogo"];
        [loginButton setTarget:self];
        [loginButton setAction:@selector(buttonAction:)];

        var cancelButton = [CPButton buttonWithTitle:"Cancel" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [cancelButton setFrame:CGRectMake(170, 100, 70, 20)];
        [contentView addSubview:cancelButton];
        [cancelButton setTag:"cancellogo"];                
        [cancelButton setTarget:self];
        [cancelButton setAction:@selector(buttonAction:)];
    
    }

    return self;
}

- (void) buttonAction:(id) sender {
    if ([delegate respondsToSelector:@selector(panelDidClose:data:)]) {
        var data = {'logourl': [logofield objectValue], 'color': [colorfield objectValue]};
        console.log('data close ', data);
        [delegate panelDidClose:[sender tag] data:data];
    }
    [self close];
}


@end