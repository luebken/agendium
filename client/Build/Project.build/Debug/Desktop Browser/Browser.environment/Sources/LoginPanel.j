@STATIC;1.0;I;21;Foundation/CPObject.jI;16;AppKit/CPPanel.jt;4090;


objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("AppKit/CPPanel.j", NO);


{var the_class = objj_allocateClassPair(CPPanel, "LoginPanel"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("delegate")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("delegate"), function $LoginPanel__delegate(self, _cmd)
{ with(self)
{
return delegate;
}
},["id"]),
new objj_method(sel_getUid("setDelegate:"), function $LoginPanel__setDelegate_(self, _cmd, newValue)
{ with(self)
{
delegate = newValue;
}
},["void","id"]), new objj_method(sel_getUid("init:"), function $LoginPanel__init_(self, _cmd, delegate2)
{ with(self)
{
    self = objj_msgSend(self, "initWithContentRect:styleMask:", CGRectMake(100.0, 100.0, 350.0, 150.0), CPHUDBackgroundWindowMask);

    if (self)
    {
        self.delegate = delegate2;
        objj_msgSend(self, "setTitle:", "Login");
        objj_msgSend(self, "setFloatingPanel:", YES);

        var contentView = objj_msgSend(self, "contentView"),
            bounds = objj_msgSend(contentView, "bounds");

        var titleLabel = objj_msgSend(CPTextField, "labelWithTitle:", "Enter your email and password to login.");
        objj_msgSend(titleLabel, "setFont:", objj_msgSend(CPFont, "systemFontOfSize:", 14.0));
        objj_msgSend(titleLabel, "sizeToFit");
        objj_msgSend(titleLabel, "setTextColor:", objj_msgSend(CPColor, "whiteColor"));
        objj_msgSend(titleLabel, "setFrameOrigin:", CGPointMake(45,5));
        objj_msgSend(contentView, "addSubview:", titleLabel);

        var emailLabel = objj_msgSend(CPTextField, "labelWithTitle:", "Email:");
        objj_msgSend(emailLabel, "setTextColor:", objj_msgSend(CPColor, "whiteColor"));
        objj_msgSend(emailLabel, "setFrameOrigin:", CGPointMake(62,40));
        objj_msgSend(contentView, "addSubview:", emailLabel);

        var emailField = objj_msgSend(CPTextField, "textFieldWithStringValue:placeholder:width:", "", "", 200);
        objj_msgSend(emailField, "setFrameOrigin:", CGPointMake(100,35));
        objj_msgSend(contentView, "addSubview:", emailField);

        var passwordLabel = objj_msgSend(CPTextField, "labelWithTitle:", "Password:");
        objj_msgSend(passwordLabel, "setTextColor:", objj_msgSend(CPColor, "whiteColor"));
        objj_msgSend(passwordLabel, "setFrameOrigin:", CGPointMake(40,70));
        objj_msgSend(contentView, "addSubview:", passwordLabel);

        var passwordField = objj_msgSend(CPTextField, "textFieldWithStringValue:placeholder:width:", "", "", 200);
        objj_msgSend(passwordField, "setFrameOrigin:", CGPointMake(100,65));
        objj_msgSend(passwordField, "setSecure:", YES);
        objj_msgSend(contentView, "addSubview:", passwordField);

        var loginButton = objj_msgSend(CPButton, "buttonWithTitle:theme:", "Login", objj_msgSend(CPTheme, "themeNamed:", "Aristo-HUD"));
        objj_msgSend(loginButton, "setFrame:", CGRectMake(250,120, 70, 20));
        objj_msgSend(contentView, "addSubview:", loginButton);
        objj_msgSend(loginButton, "setTag:", 1);
        objj_msgSend(loginButton, "setTarget:", self);
        objj_msgSend(loginButton, "setAction:", sel_getUid("buttonAction:"));

        var cancelButton = objj_msgSend(CPButton, "buttonWithTitle:theme:", "Cancel", objj_msgSend(CPTheme, "themeNamed:", "Aristo-HUD"));
        objj_msgSend(cancelButton, "setFrame:", CGRectMake(170,120, 70, 20));
        objj_msgSend(contentView, "addSubview:", cancelButton);
        objj_msgSend(cancelButton, "setTag:", 0);

        objj_msgSend(cancelButton, "setTarget:", self);
        objj_msgSend(cancelButton, "setAction:", sel_getUid("buttonAction:"));

    }

    return self;
}
},["id","id"]), new objj_method(sel_getUid("buttonAction:"), function $LoginPanel__buttonAction_(self, _cmd, sender)
{ with(self)
{
    if (objj_msgSend(delegate, "respondsToSelector:", sel_getUid("panelDidClose:"))) {
         objj_msgSend(delegate, "panelDidClose:", objj_msgSend(sender, "tag"));
    }
    objj_msgSend(self, "close");
}
},["void","id"])]);
}

