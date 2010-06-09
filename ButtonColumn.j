
@import <Foundation/CPObject.j>

@implementation ButtonColumn : CPView
{
    CPArray buttons;
    CPObject target;
    SEL action;
}

- (id)initWithTarget:(CPObject)target2 andAction:(SEL)action2  { 
        console.log('ButtonColumn.init');
        self = [super initWithFrame:CGRectMake( 10,10,10,10 )]; 
        buttons = [[CPArray alloc] init];

        self.target = target2;
        self.action = action2;

/*
        button = [CPButton buttonWithTitle:@"Delete"];
        [button setCenter:CPPointMake(50, 25)]; 
        //[button setAutoresizingMask:CPViewMaxXMargin];
        [self addSubview:button]; 

        [button setTarget:target];
        [button setAction:action];
*/
        return self; 

}

- (void) setObjectValue:(CPObject) object 
{
    var button = [CPButton buttonWithTitle:@"Delete"];
    [button setCenter:CPPointMake(50, 25)];
    [buttons addObject:button];
        [button setTarget:self.target];
        [button setAction:self.action];
    [self addSubview:button];

    //if(object)  
       // [button setTitle:object];
    console.log("setObjectValue " + object + " at " + self);
}

/*
-(CPString) description {
    return [button description];
}
*/
@end
