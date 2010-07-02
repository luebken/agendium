
@import <Foundation/CPObject.j>

@implementation PageViewController : CPViewController
{
}

/*
- (id) init
{
    if (self = [super init])
    {
        console.log('PageViewController');        
    }
    return self;
}


- (id) initWithCibName: (CPString) aCibNameOrNil
                bundle: (CPBundle) aCibBundleOrNil
{
    if (self = [super initWithCibName:aCibNameOrNil bundle:aCibBundleOrNil])
    {
        console.log('PageViewController');        
    }
    return self;
}
*/

- (@action)testMethod:(id)sender{
    console.log('action from ' + sender);
}


@end
