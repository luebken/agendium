
@import <Foundation/CPObject.j>
@import <AppKit/CPPanel.j>


@implementation UserSettingsPanel : CPPanel
{
    id delegate @accessors;
    CPTextField titleLabel;
    CPTextField oldPasswordField;
    CPTextField passwordField;
    CPTextField passwordField2;
    CPTextField errorLabel;
    CPString username;
    AgendiumConnection aConnection;
}

- (id)init:(id) delegate2 withUsername:(CPString) username2
{
    self = [self initWithContentRect:CGRectMake(250.0, 150.0, 350.0, 200.0) 
    styleMask:CPHUDBackgroundWindowMask];

    if (self)
    {
        self.username = username2;
        self.delegate = delegate2;
        [self setTitle:@"User Settings"];
        [self setFloatingPanel:YES];
        
        var contentView = [self contentView],
            bounds = [contentView bounds];

        titleLabel = [CPTextField labelWithTitle:"Change password for " + username];
        [titleLabel sizeToFit];
        [titleLabel setTextColor:[CPColor whiteColor]];
        [titleLabel setFrameOrigin:CGPointMake(15,10)];
        [contentView addSubview:titleLabel];

        var oldPasswordLabel = [CPTextField labelWithTitle:"Old Password:"];
        [oldPasswordLabel setTextColor:[CPColor whiteColor]];
        [oldPasswordLabel setFrameOrigin:CGPointMake(55,40)];
        [contentView addSubview:oldPasswordLabel];

        oldPasswordField = [CPTextField textFieldWithStringValue:"" placeholder:"" width:160];
        [oldPasswordField setFrameOrigin:CGPointMake(140,35)];
        [oldPasswordField setSecure:YES];
        [contentView addSubview:oldPasswordField];

        var passwordLabel = [CPTextField labelWithTitle:"New Password:"];
        [passwordLabel setTextColor:[CPColor whiteColor]];
        [passwordLabel setFrameOrigin:CGPointMake(48,70)];
        [contentView addSubview:passwordLabel];

        passwordField = [CPTextField textFieldWithStringValue:"" placeholder:"" width:160];
        [passwordField setFrameOrigin:CGPointMake(140,65)];
        [passwordField setSecure:YES];
        [contentView addSubview:passwordField];
        
        var passwordLabel2 = [CPTextField labelWithTitle:"Retype Password:"];
        [passwordLabel2 setTextColor:[CPColor whiteColor]];
        [passwordLabel2 setFrameOrigin:CGPointMake(35,100)];
        [contentView addSubview:passwordLabel2];

        passwordField2 = [CPTextField textFieldWithStringValue:"" placeholder:"" width:160];
        [passwordField2 setFrameOrigin:CGPointMake(140,95)];
        [passwordField2 setSecure:YES];
        [contentView addSubview:passwordField2];
        
        errorLabel = [CPTextField labelWithTitle:""];
        [errorLabel setFont:[CPFont systemFontOfSize:14.0]];
        [errorLabel setTextColor:[CPColor whiteColor]];
        [errorLabel setFrame:CGRectMake(15, 130, 300, 20)];
        
        [contentView addSubview:errorLabel];
        
        var logoutButton = [CPButton buttonWithTitle:"Logout" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [logoutButton setFrame:CGRectMake(30, 165, 70, 20)];
        [contentView addSubview:logoutButton];
        [logoutButton setTag:"logout"];
        [logoutButton setTarget:self];
        [logoutButton setAction:@selector(buttonAction:)];        
        
        var changeButton = [CPButton buttonWithTitle:"Change" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [changeButton setFrame:CGRectMake(250, 165, 70, 20)];
        [contentView addSubview:changeButton];
        [changeButton setTag:"changepassword"];
        [changeButton setTarget:self];
        [changeButton setAction:@selector(buttonAction:)];

        var cancelButton = [CPButton buttonWithTitle:"Close" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [cancelButton setFrame:CGRectMake(170, 165, 70, 20)];
        [contentView addSubview:cancelButton];
        [cancelButton setTag:"close"];
        [cancelButton setTarget:self];
        [cancelButton setAction:@selector(buttonAction:)];
        
        aConnection = [[AgendiumConnection alloc] init];
    }

    return self;
}

- (boolean) validateFields {
    if([oldPasswordField objectValue].length === 0) {
        [errorLabel setObjectValue:'Please specify your old password.'];
        return NO;
    }
    if([passwordField objectValue].length === 0) {
        [errorLabel setObjectValue:'Please specify your new password.'];
        return NO;
    }
    if([passwordField objectValue] != [passwordField2 objectValue]) {
        [errorLabel setObjectValue:"Your new passwords don't match."];
        return NO;
    }
    return YES;
}

- (void) buttonAction:(id) sender {
    var tag = [sender tag];
    [errorLabel setObjectValue:'']
    switch(tag) {
        case "changepassword":
            if([self validateFields]) {
                [aConnection changePassword:[oldPasswordField objectValue] toPassword:[passwordField objectValue] forUser:self.username delegate:self]
            }
            break;
        case "close":
            [self close];
            break;
        case "logout":
            history.go(-1);
            [self close];
            break;
    }
 
}

- (void) didChangePassword{
    [errorLabel setObjectValue:"Password changed."];
    [passwordField setObjectValue:""];
    [passwordField2 setObjectValue:""];
    [oldPasswordField setObjectValue:""];
    
}
- (void) didntChangePassword{
    [errorLabel setObjectValue:"Couldn't change password!"];
}




@end