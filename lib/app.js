/**
 * Module dependencies.
 */
require.paths.unshift("./vendor/lib")
var express = require('express'),
    connect = require('connect'),
    haml = require('haml'),
    sys = require('sys');
        
/**
 * Setup
 */
var pub = __dirname + '/public';

var app = express.createServer();
exports.app = app;
app.configure(function(){ 
    app.use(connect.bodyDecoder()); 
    app.use(connect.methodOverride()); 
    app.use(connect.staticProvider(pub));
});
app.set('views', __dirname + '/views')


var PageProvider = require('./pageprovider-memory').PageProvider;
var pageProvider = new PageProvider();

var UserProvider = require('./userprovider').UserProvider;
var userProvider = new UserProvider();
userProvider.checkUser('mdl', function(found) {
    if(!found){
        userProvider.save([{'email':'mdl', 'password':''}]);
    }
});
userProvider = new UserProvider();
userProvider.checkUser('mdl', function(result) {console.log('mdl: ' + result)});
userProvider = new UserProvider();
userProvider.checkUser('mdl2', function(result) {console.log('mdl2: ' + result)});


// === agenda crud  ===
app.get('/agenda/:id', function(req, res){
    pageProvider.findById(req.params.id, function(error, data){
        if(data != null) {
            res.send(JSON.stringify(data), { 'Content-Type': 'application/json' }, 200);            
        } else {
            res.send(null, 404);                        
        }
    })
})
app.post('/agenda', function(req, res){
    var data = JSON.parse(req.rawBody);   
    pageProvider.save(data, function(error, data2) {
        res.send(JSON.stringify(data2), 200);            
    });
  //res.send("null", 200);
});

// === mobile client  ===
//Serves the mobile client
app.get('/a/:id', function(req, res){
    var idx = pageProvider.findIndexById(req.params.id);
    var data = pageProvider.dummyData[idx];    
    res.render('index.html.haml', {
      layout: false,
      locals: {
        appid: req.params.id,
        rootpage: data.rootpage
      }
    })
})

//Serves the mobile client
app.get('/preview', function(req, res){
    res.render('emptypreview.html.haml', {
      layout: false
    })
})

//Serves the agenda data as JSON for the mobile client 
//FIXME why not use get('/agenda/*' just because auf "var data"
app.get('/data/:id', function(req, res){
    pageProvider.findById(req.params.id, function(error, data){
        if(data != null) {
            res.send('var data = ' + JSON.stringify(data), { 'Content-Type': 'application/json' }, 200);            
        } else {
            res.send(null, 404);                        
        }
    })
})

// === agenda crud  ===
app.get('/user/:email', function(req, res){
    userProvider.checkUser(req.params.email, function(data){
        res.send(JSON.stringify(data), { 'Content-Type': 'application/json' }, 200);            
    })
})