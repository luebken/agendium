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
    CPURLConnection passwordConnection;
    id passwordDelegate;
}
- (id)init
{
    self = [super init];
    return self;
}


- (void) loadAgendaFor:(CPString)userid andName:(CPString)name withDelegate:(id)delegate {
    var request = [CPURLRequest requestWithURL:BASEURL+"agenda/"+userid+"/" + name];
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

- (void) changePassword:(CPString)oldPassword toPassword:(CPString)newPassword forUser:(CPString)user delegate:(id)delegate {
    CPLog('Requesting to change password for user ' + user);
    var request = [CPURLRequest requestWithURL:BASEURL+"password/"];
    [request setHTTPMethod:'POST'];
    var jsonData = '{"oldpassword":"' + oldPassword + '","newpassword":"' + newPassword + '", "user":"'+ user + '"}';
    CPLog('Posting ' + jsonData);
    [request setHTTPBody:jsonData];
    [request setValue:'application/json' forHTTPHeaderField:"Accept"];
    [request setValue:'application/json' forHTTPHeaderField:"Content-Type"];
    passwordConnection = [CPURLConnection connectionWithRequest:request delegate:self];
    passwordDelegate = delegate;
}

- (void) saveAgenda:(id)appId rootPage:(Page) rootPage userid:(CPString)userid delegate:(id)delegate {
    var request = [CPURLRequest requestWithURL:BASEURL + "agenda"];
    [request setHTTPMethod:'POST'];
    var jsonData = '{"_id":"' + appId + '","userid":"' + userid + '", "rootpage":'+ [rootPage toJSON] + '}';
    [request setHTTPBody:jsonData];
    [request setValue:'application/json' forHTTPHeaderField:"Accept"];
    [request setValue:'application/json' forHTTPHeaderField:"Content-Type"];
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
    if(connection == passwordConnection) {
        [self didReceiveChangePassword:data delegate:passwordDelegate];
    }
    
}
-(void)connection:(CPURLConnection)connection didFailWithError:(id)error {
    CPLog("didFailWithError: " + error);
    alert(error);
}
//CPURLConnection delegate
-(void)connection:(CPURLConnection)connection didFailWithError:(id)error {
    CPLog("didFailWithError: " + error);
    alert(error);
}
//CPURLConnection delegate
-(void)connection:(CPURLConnection)connection didReceiveResponse:(CPHTTPURLResponse)response {
    CPLog("didReceiveResponse for url:" + [response URL] + " and status " + [response statusCode]);
}

//
//private
//
-(void)didReceiveSaveData:(CPString)data delegate:(id)delegate {
    if(data) {
        try {
            var obj = JSON.parse(data);
            [delegate didReceiveAgenda:obj._id withRootPage:undefined];
        } catch (e) {
            [delegate failureWhileReceivingAgenda:@"Error while parsing Data: " + e];
        } 
    } else {
        CPLog('No data');
        [delegate failureWhileReceivingAgenda:'Couldn\'t save the Agenda'];
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
        CPLog('failureWhileReceivingAgenda');
        [delegate failureWhileReceivingAgenda:'Couldn\'t find the Agenda'];
    }
}
-(void)didReceiveLoginData:(CPString)data delegate:(id)delegate {    
    if(data && data != "undefined") {
        var obj = JSON.parse(data);
        [delegate loginSuccessFor:obj.email withId:obj._id];
    } else {
        [delegate loginFailed];        
    }
}

-(void)didReceiveCheckNameData:(CPString)data delegate:(id)delegate {
    [delegate didReceiveCheckName:(data === 'true')];
}

-(void)didReceiveChangePassword:(CPString)data delegate:(id)delegate {
    CPLog('didReceiveChangePassword: ' + data)
    if(data != null && data != '' && data != 'null') {
        try {
            var parsed = JSON.parse(data);
            if(parsed.changed) {
                [delegate didChangePassword];
                return;
            } else {
                [delegate didntChangePassword];
                return;                
            }
        } catch (e) {
        } 
    } 
    CPLog('Error didReceiveChangePassword');
    [delegate didntChangePassword];
}

@end
