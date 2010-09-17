
@import <Foundation/CPObject.j>
@import <AppKit/CPPanel.j>


@implementation LoginPanel : CPPanel
{
    id delegate @accessors;
    CPTextField titleLabel;
    CPTextField emailField;
    CPTextField passwordField;
    
    AgendiumConnection aConnection;
}

- (id)init:(id) delegate2
{
    self = [self initWithContentRect:CGRectMake(250.0, 150.0, 350.0, 170.0) 
    styleMask:CPHUDBackgroundWindowMask];

    if (self)
    {
        self.delegate = delegate2;
        [self setTitle:@"Private Beta Login"];
        [self setFloatingPanel:YES];
        
        var contentView = [self contentView],
            bounds = [contentView bounds];

        titleLabel = [CPTextField labelWithTitle:"Enter your email and password to login."];
        [titleLabel setFont:[CPFont systemFontOfSize:14.0]];
        [titleLabel sizeToFit];
        [titleLabel setTextColor:[CPColor whiteColor]];
        [titleLabel setFrameOrigin:CGPointMake(45,5)];
        [contentView addSubview:titleLabel];

        var emailLabel = [CPTextField labelWithTitle:"Email:"];
        [emailLabel setTextColor:[CPColor whiteColor]];
        [emailLabel setFrameOrigin:CGPointMake(62,40)];
        [contentView addSubview:emailLabel];

        emailField = [CPTextField textFieldWithStringValue:"" placeholder:"" width:200];
        [emailField setFrameOrigin:CGPointMake(100,35)];
        [contentView addSubview:emailField];

        var passwordLabel = [CPTextField labelWithTitle:"Password:"];
        [passwordLabel setTextColor:[CPColor whiteColor]];
        [passwordLabel setFrameOrigin:CGPointMake(40,70)];
        [contentView addSubview:passwordLabel];

        passwordField = [CPTextField textFieldWithStringValue:"" placeholder:"" width:200];
        [passwordField setFrameOrigin:CGPointMake(100,65)];
        [passwordField setSecure:YES];
        [contentView addSubview:passwordField];

        var loginButton = [CPButton buttonWithTitle:"Login" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [loginButton setFrame:CGRectMake(250,110, 70, 20)];
        [contentView addSubview:loginButton];
        [loginButton setTag:"login"];
        [loginButton setTarget:self];
        [loginButton setAction:@selector(buttonAction:)];

        var cancelButton = [CPButton buttonWithTitle:"Cancel" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [cancelButton setFrame:CGRectMake(170,110, 70, 20)];
        [contentView addSubview:cancelButton];
        [cancelButton setTag:"logincancel"];
        
        var signUpButton = [CPButton buttonWithTitle:"Want to be part of the fun? Sign up."];
        [signUpButton sizeToFit];
        [signUpButton setFrameOrigin:CGPointMake(80,140)];  
        [signUpButton setBordered:NO]; 
        [signUpButton setTextColor:[CPColor grayColor]];
        signUpButton._DOMElement.style.textDecoration = "underline";
        [signUpButton setTarget:self]; 
        [signUpButton setAction:@selector(signup)]; 
        signUpButton._DOMElement.style.cursor = "pointer"; 
        
        [contentView addSubview:signUpButton];
        [cancelButton setTarget:self];
        [cancelButton setAction:@selector(buttonAction:)];
        
        aConnection = [[AgendiumConnection alloc] init];
    }

    return self;
}

- (void) buttonAction:(id) sender {
    if([sender tag] == "login") {
        console.log('trying to login ' + [emailField objectValue]);
        [aConnection checkUser:[emailField objectValue] withPassword:[passwordField objectValue] delegate:self];
    } else if([sender tag] == "logincancel") {
        console.log(@"login canceled");
        history.go(-1);
        [self close];
    }    
}

- (void) loginSuccess: (String) userid{
    if ([delegate respondsToSelector:@selector(panelDidClose:data:)]) {
        [delegate panelDidClose:'login' data:userid];
        [self close];
    }    
}
- (void) loginFailed{
    [titleLabel setObjectValue:'Login failed. Please try again.'];
    console.log('loginFailed');
}

- (void) signup {
    window.open ("https://spreadsheets.google.com/viewform?formkey=dFJWN29DR09fanRfRnVic255Z1hVMEE6MQ","_self");
}


@end