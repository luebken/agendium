@import <Foundation/CPObject.j>
@import "Page.j"


@implementation AgendiumConnection : CPObject
{
    CPURLConnection listConnection;
    id listDelegate;
    CPURLConnection saveConnection;
    CPString baseURL;
}
- (id)init
{
    self = [super init];
    baseURL = @"http://localhost:8000/";
    return self;
}


- (void) loadAgenda:(CPString)title delegate:delegate {
    console.log(@"loading...");
    var request = [CPURLRequest requestWithURL:baseURL+"agenda/"+title];
    [request setHTTPMethod:'GET'];
    listConnection = [CPURLConnection connectionWithRequest:request delegate:self];
    listDelegate = delegate;
}
- (void) save:(Page) rootPage {
    var request = [CPURLRequest requestWithURL:baseURL + "agenda"];
    [request setHTTPMethod:'POST'];
    var jsonData = '{"_id":"' + appId + '", "rootpage":'+ [rootPage toJSON] + '}';
    console.log("Saving JSON: " + jsonData)
    [request setHTTPBody:jsonData];
    [request setValue:'application/json' forHTTPHeaderField:"Accept"];
    [request setValue:'application/json' forHTTPHeaderField:"Content-Type"];
    
    //console.log("[request HTTPBody]: " + [request HTTPBody]);
    //console.log("[request allHTTPHeaderFields]: " + [request allHTTPHeaderFields]);
    
    saveConnection = [CPURLConnection connectionWithRequest:request delegate:self];
}


//
//CPURLConnection delegate
//
-(void)connection:(CPURLConnection)connection didReceiveData:(CPString)data {
    console.log("didReceiveData: '" + data + "'");
    if(connection == saveConnection) {
        var popup = [[CPAlert alloc] init];
        //[alert setWindowStyle:CPHUDBackgroundWindowMask];
        [popup setAlertStyle:CPInformationalAlertStyle];
        [popup setMessageText:"Saved!"];
        [popup addButtonWithTitle:@"OK"];
        [popup runModal];
    }
    if(connection == listConnection) {
        [self didReceiveLoadData:data];
    }
}
-(void)connection:(CPURLConnection)connection didFailWithError:(id)error {
    console.log("didFailWithError: " + error);
    alert(error);
}
-(void)connection:(CPURLConnection)connection didReceiveResponse:(CPHTTPURLResponse)response {
    console.log("didReceiveResponse for URL:" + [response URL]);
}

//
//private
//
-(void)didReceiveLoadData:(CPString)data {
    if(data != null && data != '' && data != 'null') {
        try {
            var obj = JSON.parse(data);
            var rootPage = [Page initFromJSONObject:obj.rootpage andNavigationId:"r"];
            [listDelegate didReceiveAgenda:obj._id withRootPage:rootPage]
        } catch (e) {
            [listDelegate failureWhileReceivingAgenda:@"Error while parsing Data: " + e];
        } 
    } else {
        console.log('failureWhileReceivingAgenda');
        [listDelegate failureWhileReceivingAgenda:'Couldn\'t find the Agenda'];
    }
}

@end
