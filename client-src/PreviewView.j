@import <Foundation/CPObject.j>


@implementation PreviewView : CPWebView
{
    
}

- (id)initWithCoder:(CPCoder)aCoder{
    if (self = [super initWithCoder:aCoder]) {
        [self setFrame:CPRectMake(540, 100, 340, 520)];

        //[[theWindow contentView] addSubview:previewView];
        //[previewView setScrollMode:CPWebViewScrollAppKit];
        //[previewView._scrollView setAutohidesScrollers:YES];

        self._DOMElement.style.webkitTransformOrigin = "10 10";
        self._DOMElement.style.webkitTransform = "scale(0.75)";
        //previewView._DOMElement.style.overflow = "hidden";

        //previewView._DOMElement.style.width = "340px";
        //previewView._DOMElement.style.height = "520px";

        //previewView._iframe.style.webkitTransformOrigin = "0 0"; 
        //previewView._iframe.style.webkitTransform = "scale(0.75)"; 
        //previewView._iframe.style.opacity = "0"; 
        //previewView._frameView._DOMElement.style.opacity = "0"; 
        //previewView._scrollView._DOMElement.style.opacity = "0";
    }
    return self;
}

//PageViewController Delegate
- (void) changePageTo:(CPString) pageid animate:(Boolean) animate reverse:(Boolean) reverse {
    var animation = animate ? 'slide' : 'none';
    var cmd = "if($.mobile.activePage.attr('id') != $('#"+pageid+"').attr('id')) $.mobile.changePage($('#"+pageid+"'), '"+animation+"', "+reverse+")"
    CPLog("cmd " + cmd);
    [[self windowScriptObject] evaluateWebScript:cmd];
}

@end