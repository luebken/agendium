
@import <Foundation/CPObject.j>
@import <AppKit/CPPanel.j>


@implementation LoginPanel : CPPanel
{
    id delegate @accessors;
}

- (id)init:(id) delegate2
{
    self = [self initWithContentRect:CGRectMake(200.0, 150.0, 350.0, 170.0) 
    styleMask:CPHUDBackgroundWindowMask];

    if (self)
    {
        self.delegate = delegate2;
        [self setTitle:@"Private Beta Login"];
        [self setFloatingPanel:YES];
        
        var contentView = [self contentView],
            bounds = [contentView bounds];

        var titleLabel = [CPTextField labelWithTitle:"Enter your email and password to login."];
        [titleLabel setFont:[CPFont systemFontOfSize:14.0]];
        [titleLabel sizeToFit];
        [titleLabel setTextColor:[CPColor whiteColor]];
        [titleLabel setFrameOrigin:CGPointMake(45,5)];
        [contentView addSubview:titleLabel];

        var emailLabel = [CPTextField labelWithTitle:"Email:"];
        [emailLabel setTextColor:[CPColor whiteColor]];
        [emailLabel setFrameOrigin:CGPointMake(62,40)];
        [contentView addSubview:emailLabel];

        var emailField = [CPTextField textFieldWithStringValue:"" placeholder:"" width:200];
        [emailField setFrameOrigin:CGPointMake(100,35)];
        [contentView addSubview:emailField];

        var passwordLabel = [CPTextField labelWithTitle:"Password:"];
        [passwordLabel setTextColor:[CPColor whiteColor]];
        [passwordLabel setFrameOrigin:CGPointMake(40,70)];
        [contentView addSubview:passwordLabel];

        var passwordField = [CPTextField textFieldWithStringValue:"" placeholder:"" width:200];
        [passwordField setFrameOrigin:CGPointMake(100,65)];
        [passwordField setSecure:YES];
        [contentView addSubview:passwordField];

        var loginButton = [CPButton buttonWithTitle:"Login" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [loginButton setFrame:CGRectMake(250,110, 70, 20)];
        [contentView addSubview:loginButton];
        [loginButton setTag:1];
        [loginButton setTarget:self];
        [loginButton setAction:@selector(buttonAction:)];

        var cancelButton = [CPButton buttonWithTitle:"Cancel" theme:[CPTheme themeNamed:"Aristo-HUD"]];
        [cancelButton setFrame:CGRectMake(170,110, 70, 20)];
        [contentView addSubview:cancelButton];
        [cancelButton setTag:0];
        
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
    
    }

    return self;
}

- (void) buttonAction:(id) sender {
    if ([delegate respondsToSelector:@selector(panelDidClose:)]) {
         [delegate panelDidClose:[sender tag]];
    }
    [self close];
}

- (void) signup {
    window.open ("https://spreadsheets.google.com/viewform?formkey=dFJWN29DR09fanRfRnVic255Z1hVMEE6MQ","_self");
}


@end