@import <Foundation/CPObject.j>
@import <AppKit/CPPanel.j>


@implementation SharePanel : CPPanel
{
    id delegate @accessors;
    id appname;
}

- (id)init:(id) delegate2 andAppname:(CPString)appname2
{
    self = [self initWithContentRect:CGRectMake(200.0, 110.0, 310.0, 130.0)
    styleMask:CPHUDBackgroundWindowMask];
    self.appname = appname2;

    if (self)
    {
        self.delegate = delegate2;
        [self setTitle:@"Share"];
        [self setFloatingPanel:YES];
        
        var contentView = [self contentView],
            bounds = [contentView bounds];

        var titleLabel = [CPTextField labelWithTitle:"Share your agenda:"];
        [titleLabel setFont:[CPFont systemFontOfSize:14.0]];
        [titleLabel sizeToFit];
        [titleLabel setTextColor:[CPColor whiteColor]];
        [titleLabel setFrameOrigin:CGPointMake(35,17)];
        [contentView addSubview:titleLabel];

        var twitterButton = [CPButton buttonWithTitle:"via Twitter" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [twitterButton setFrame:CGRectMake(170, 5, 110, 20)];
        [contentView addSubview:twitterButton];
        [twitterButton setTag:"twitter"];                
        [twitterButton setTarget:self];
        [twitterButton setAction:@selector(buttonAction:)];

        var emailButton = [CPButton buttonWithTitle:"via Email" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [emailButton setFrame:CGRectMake(170,35, 110, 20)];
        [contentView addSubview:emailButton];
        [emailButton setTag:"email"];                
        [emailButton setTarget:self];
        [emailButton setAction:@selector(buttonAction:)];

        var cancelButton = [CPButton buttonWithTitle:"Cancel" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [cancelButton setFrame:CGRectMake(170,80, 110, 20)];
        [contentView addSubview:cancelButton];
        [cancelButton setTag:"cancel"];                
        [cancelButton setTarget:self];
        [cancelButton setAction:@selector(buttonAction:)];

    
    }

    return self;
}

- (void) buttonAction:(id) sender {
    switch([sender tag]) {
        case 'email': 
            window.open("mailto:matthias@luebken.com?body=I've created an agenda for "+appname+". Open it on your smartphone http://touchium.com/a/"+appname,"emailwindow");
            window.close("emailwindow");
            break;
        case 'twitter':
            window.open("http://twitter.com/?status=I've created an agenda for "+appname+". Open it on your smartphone http://touchium.com/a/"+appname,"twitterwindow");
    }
        
    
    [delegate panelDidClose:[sender tag] data:nil];
    [self close];
}


@end