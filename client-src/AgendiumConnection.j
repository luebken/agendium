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
    CPURLConnection checkNameConnection;
    id checkNameDelegate;
}
- (id)init
{
    self = [super init];
    return self;
}


- (void) loadAgenda:(CPString)name delegate:(id)delegate {
    var request = [CPURLRequest requestWithURL:BASEURL+"agenda/" + name];
    [request setHTTPMethod:'GET'];
    listConnection = [CPURLConnection connectionWithRequest:request delegate:self];
    listDelegate = delegate;
}

- (void) checkUser:(CPString)email withPassword:(CPString)password delegate:(id)delegate {
    var request = [CPURLRequest requestWithURL:BASEURL+"user/"+email+"/"+password];
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
    //console.log("Saving JSON: " + jsonData)    
    saveConnection = [CPURLConnection connectionWithRequest:request delegate:self];
    saveDelegate = delegate;
}

- (void) checkAppName:(CPString)name forId:(CPString)id delegate:(id)delegate {
    var request = [CPURLRequest requestWithURL:BASEURL+"isnameok/" + name + "/" + id];
    [request setHTTPMethod:'GET'];
    checkNameConnection = [CPURLConnection connectionWithRequest:request delegate:self];
    checkNameDelegate = delegate;
}


//
//CPURLConnection delegate
//
-(void)connection:(CPURLConnection)connection didReceiveData:(CPString)data {
    //console.log("didReceiveData: '" + data + "'");
    if(connection == saveConnection) {
        [self didReceiveSaveData:data delegate:saveDelegate];
    }
    if(connection == listConnection) {
        [self didReceiveLoadData:data delegate:listDelegate];
    }
    if(connection == loginConnection) {
        [self didReceiveLoginData:data delegate:loginDelegate];
    }
    if(connection == checkNameConnection) {
        [self didReceiveCheckNameData:data delegate:checkNameDelegate];
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
-(void)didReceiveSaveData:(CPString)data delegate:(id)delegate {
    if(data != null && data != '' && data != 'null') {
        try {
            var obj = JSON.parse(data);
            [delegate didReceiveAgenda:obj._id]
        } catch (e) {
            [delegate failureWhileReceivingAgenda:@"Error while parsing Data: " + e];
        } 
    } else {
        console.log('failureWhileReceivingAgenda');
        [delegate failureWhileReceivingAgenda:'Couldn\'t find the Agenda'];
    }
}
-(void)didReceiveLoadData:(CPString)data delegate:(id)delegate {
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
    if(data && data != "undefined") {
        var obj = JSON.parse(data);
        console.log("didReceiveLoginData " + obj.email);
        [delegate loginSuccess];
    } else {
        [delegate loginFailed];        
    }
}

-(void)didReceiveCheckNameData:(CPString)data delegate:(id)delegate {
    [delegate didReceiveCheckName:data];
}

@end
