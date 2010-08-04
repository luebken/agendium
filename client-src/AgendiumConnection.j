@import <Foundation/CPObject.j>
@import "Page.j"
@import "Config.j"

@implementation AgendiumConnection : CPObject
{
    CPURLConnection listConnection;
    id listDelegate;
    CPURLConnection saveConnection;
    id saveDelegate;
    CPURLConnection loginConnection;
    id loginDelegate;
}
- (id)init
{
    self = [super init];
    return self;
}


- (void) loadAgenda:(CPString)id delegate:(id)delegate {
    console.log(@"loading...");
    var request = [CPURLRequest requestWithURL:BASEURL+"agenda/"+id];
    [request setHTTPMethod:'GET'];
    listConnection = [CPURLConnection connectionWithRequest:request delegate:self];
    listDelegate = delegate;
}

- (void) checkUser:(CPString)email delegate:(id)delegate {
    console.log(@"checkUser...");
    var request = [CPURLRequest requestWithURL:BASEURL+"user/"+email];
    [request setHTTPMethod:'GET'];
    loginConnection = [CPURLConnection connectionWithRequest:request delegate:self];
    loginDelegate = delegate;
}

- (void) saveAgenda:(id)appId rootPage:(Page) rootPage delegate:(id)delegate {
    var request = [CPURLRequest requestWithURL:BASEURL + "agenda"];
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
        [self didReceivePageData:data delegate:saveDelegate];
    }
    if(connection == listConnection) {
        [self didReceivePageData:data delegate:listDelegate];
    }
    if(connection == loginConnection) {
        [self didReceiveLoginData:data delegate:loginDelegate];
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
-(void)didReceivePageData:(CPString)data delegate:(id)delegate {
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
-(void)didReceiveLoginData:(CPString)data delegate:(id)delegate {
    if("true" === data) {
        [delegate loginSuccess];
    } else {
        [delegate loginFailed];        
    }
}

@end
