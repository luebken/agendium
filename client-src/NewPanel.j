@import <Foundation/CPObject.j>
@import <AppKit/CPPanel.j>
@import "DatePicker/DatePicker.j"



@implementation NewPanel : CPPanel
{
    id delegate @accessors;
    id theDatePicker;
}

- (id)init:(id) delegate2
{
    self = [self initWithContentRect:CGRectMake(200.0, 110.0, 310.0, 160.0) 
    styleMask:CPHUDBackgroundWindowMask];

    if (self)
    {
        self.delegate = delegate2;
        [self setTitle:@"New Agenda"];
        [self setFloatingPanel:YES];
        
        var contentView = [self contentView],
            bounds = [contentView bounds];
            
        var firstDateLabel = [CPTextField labelWithTitle:"Starting date:"];
        [firstDateLabel setFont:[CPFont systemFontOfSize:14.0]];
        [firstDateLabel sizeToFit];
        [firstDateLabel setTextColor:[CPColor whiteColor]];
        [firstDateLabel setFrameOrigin:CGPointMake(30,15)];
        [contentView addSubview:firstDateLabel];
        
        theDatePicker = [[DatePicker alloc] initWithFrame:CGRectMake(120,10,100,30)];
        [theDatePicker displayPreset:1];
        [theDatePicker setDelegate:self];

        var titleLabel = [CPTextField labelWithTitle:"Choose your agenda template:"];
        [titleLabel setFont:[CPFont systemFontOfSize:14.0]];
        [titleLabel sizeToFit];
        [titleLabel setTextColor:[CPColor whiteColor]];
        [titleLabel setFrameOrigin:CGPointMake(30,50)];
        [contentView addSubview:titleLabel];

        var oneDayOneTrackButton = [CPButton buttonWithTitle:"1 day 1 track" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [oneDayOneTrackButton setFrame:CGRectMake(30, 80, 110, 20)];
        [contentView addSubview:oneDayOneTrackButton];
        [oneDayOneTrackButton setTag:"onedayonetrack"];                
        [oneDayOneTrackButton setTarget:self];
        [oneDayOneTrackButton setAction:@selector(buttonAction:)];

        var threeDaysTwoTracksButton = [CPButton buttonWithTitle:"3 days 2 tracks" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [threeDaysTwoTracksButton setFrame:CGRectMake(170, 80, 110, 20)];
        [contentView addSubview:threeDaysTwoTracksButton];
        [threeDaysTwoTracksButton setTag:"threedaytwotracks"];                
        [threeDaysTwoTracksButton setTarget:self];
        [threeDaysTwoTracksButton setAction:@selector(buttonAction:)];

        var emptyButton = [CPButton buttonWithTitle:"Empty" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [emptyButton setFrame:CGRectMake(30, 110, 110, 20)];
        [contentView addSubview:emptyButton];
        [emptyButton setTag:"empty"];                
        [emptyButton setTarget:self];
        [emptyButton setAction:@selector(buttonAction:)];

        var cancelButton = [CPButton buttonWithTitle:"Cancel" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [cancelButton setFrame:CGRectMake(170, 110, 110, 20)];
        [contentView addSubview:cancelButton];
        [cancelButton setTag:"cancel"];                
        [cancelButton setTarget:self];
        [cancelButton setAction:@selector(buttonAction:)];
        



        [contentView addSubview:theDatePicker];

    
    }

    return self;
}

- (void)datePickerDidChange:(id) notification {
    var date = [[notification object] date];
    //console.log("date " + date);
}

- (void) buttonAction:(id) sender {
    [delegate panelDidClose:[sender tag] data:[theDatePicker date]];
    [self close];
}


@end