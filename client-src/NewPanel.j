@import <Foundation/CPObject.j>
@import <AppKit/CPPanel.j>


@implementation NewPanel : CPPanel
{
    id delegate @accessors;
}

- (id)init:(id) delegate2
{
    self = [self initWithContentRect:CGRectMake(200.0, 150.0, 310.0, 170.0) 
    styleMask:CPHUDBackgroundWindowMask];

    if (self)
    {
        self.delegate = delegate2;
        [self setTitle:@"New Agenda"];
        [self setFloatingPanel:YES];
        
        var contentView = [self contentView],
            bounds = [contentView bounds];

        var titleLabel = [CPTextField labelWithTitle:"Choose your agenda template:"];
        [titleLabel setFont:[CPFont systemFontOfSize:14.0]];
        [titleLabel sizeToFit];
        [titleLabel setTextColor:[CPColor whiteColor]];
        [titleLabel setFrameOrigin:CGPointMake(45,5)];
        [contentView addSubview:titleLabel];

        var threeDaysOneTrackButton = [CPButton buttonWithTitle:"3 days 1 track" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [threeDaysOneTrackButton setFrame:CGRectMake(30, 50, 110, 20)];
        [contentView addSubview:threeDaysOneTrackButton];
        [threeDaysOneTrackButton setTag:"threedaytwotracks"];                
        [threeDaysOneTrackButton setTarget:self];
        [threeDaysOneTrackButton setAction:@selector(buttonAction:)];

        var threeDaysTwoTracksButton = [CPButton buttonWithTitle:"3 days 2 tracks" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [threeDaysTwoTracksButton setFrame:CGRectMake(170,50, 110, 20)];
        [contentView addSubview:threeDaysTwoTracksButton];
        [threeDaysTwoTracksButton setTag:"threedaytwotracks"];                
        [threeDaysTwoTracksButton setTarget:self];
        [threeDaysTwoTracksButton setAction:@selector(buttonAction:)];
        
        var fiveDaysOneTrackButton = [CPButton buttonWithTitle:"5 days 1 track" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [fiveDaysOneTrackButton setFrame:CGRectMake(30, 80, 110, 20)];
        [contentView addSubview:fiveDaysOneTrackButton];
        [fiveDaysOneTrackButton setTag:"threedaytwotracks"];                
        [fiveDaysOneTrackButton setTarget:self];
        [fiveDaysOneTrackButton setAction:@selector(buttonAction:)];

        var fiveDaysTwoTracksButton = [CPButton buttonWithTitle:"3 days 2 tracks" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [fiveDaysTwoTracksButton setFrame:CGRectMake(170,80, 110, 20)];
        [contentView addSubview:fiveDaysTwoTracksButton];
        [fiveDaysTwoTracksButton setTag:"threedaytwotracks"];                
        [fiveDaysTwoTracksButton setTarget:self];
        [fiveDaysTwoTracksButton setAction:@selector(buttonAction:)];

        var emptyButton = [CPButton buttonWithTitle:"Empty" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [emptyButton setFrame:CGRectMake(30, 120, 110, 20)];
        [contentView addSubview:emptyButton];
        [emptyButton setTag:"empty"];                
        [emptyButton setTarget:self];
        [emptyButton setAction:@selector(buttonAction:)];

        var cancelButton = [CPButton buttonWithTitle:"Cancel" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [cancelButton setFrame:CGRectMake(170,120, 110, 20)];
        [contentView addSubview:cancelButton];
        [cancelButton setTag:"cancel"];                
        [cancelButton setTarget:self];
        [cancelButton setAction:@selector(buttonAction:)];

    
    }

    return self;
}

- (void) buttonAction:(id) sender {
    [delegate panelDidClose:[sender tag] data:nil];
    [self close];
}


@end