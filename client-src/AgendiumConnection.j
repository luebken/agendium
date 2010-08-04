@import <Foundation/CPObject.j>
@import "Page.j"


@implementation AgendiumConnection : CPObject
{
    CPURLConnection listConnection;
    id listDelegate;
    CPURLConnection saveConnection;
    id saveDelegate;
    
    CPString baseURL @accessors;
}
- (id)init
{
    self = [super init];
    //baseURL = @"http://agendium.heroku.com/";
    baseURL = @"http://localhost:8000/";
    return self;
}


- (void) loadAgenda:(CPString)id delegate:(id)delegate {
    console.log(@"loading...");
    var request = [CPURLRequest requestWithURL:baseURL+"agenda/"+id];
    [request setHTTPMethod:'GET'];
    listConnection = [CPURLConnection connectionWithRequest:request delegate:self];
    listDelegate = delegate;
}

- (void) saveAgenda:(id)appId rootPage:(Page) rootPage delegate:(id)delegate {
    var request = [CPURLRequest requestWithURL:baseURL + "agenda"];
    [request setHTTPMethod:'POST'];
    var jsonData = '{"_id":"' + appId + '", "rootpage":'+ [rootPage toJSON] + '}';
    [request setHTTPBody:jsonData];
    [request setValue:'application/json' forHTTPHeaderField:"Accept"];
    [request setValue:'application/json' forHTTPHeaderField:"Content-Type"];
    
    //console.log("[request HTTPBody]: " + [request HTTPBody]);
    //console.log("[request allHTTPHeaderFields]: " + [request allHTTPHeaderFields]);
    console.log("Saving JSON: " + jsonData)    
    saveConnection = [CPURLConnection connectionWithRequest:request delegate:self];
    saveDelegate = delegate;
}


//
//CPURLConnection delegate
//
-(void)connection:(CPURLConnection)connection didReceiveData:(CPString)data {
    console.log("didReceiveData: '" + data + "'");
    if(connection == saveConnection) {
        [self didReceiveData:data delegate:saveDelegate];
    }
    if(connection == listConnection) {
        [self didReceiveData:data delegate:listDelegate];
    }
}
-(void)connection:(CPURLConnection)connection didFailWithError:(id)error {
    console.log("didFailWithError: " + error);
    alert(error);
}
-(void)connection:(CPURLConnection)connection didReceiveResponse:(CPHTTPURLResponse)response {
    console.log("didReceiveResponse for URL:" + [response URL]);
}
//CPURLConnection delegate
-(void)connection:(CPURLConnection)connection didFailWithError:(id)error {
    console.log("didFailWithError: " + error);
    alert(error);
}
//CPURLConnection delegate
-(void)connection:(CPURLConnection)connection didReceiveResponse:(CPHTTPURLResponse)response {
    console.log("didReceiveResponse for URL:" + [response URL]);
}

//
//private
//
-(void)didReceiveData:(CPString)data delegate:(id)delegate {
    if(data != null && data != '' && data != 'null') {
        try {
            var obj = JSON.parse(data);
            var rootPage = [Page initFromJSONObject:obj.rootpage andNavigationId:"r"];
            [delegate didReceiveAgenda:obj._id withRootPage:rootPage]
        } catch (e) {
            [delegate failureWhileReceivingAgenda:@"Error while parsing Data: " + e];
        } 
    } else {
        console.log('failureWhileReceivingAgenda');
        [delegate failureWhileReceivingAgenda:'Couldn\'t find the Agenda'];
    }
}

@end
