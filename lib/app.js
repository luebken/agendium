/**
 * Module dependencies.
 */
require.paths.unshift("./vendor/lib")
var express = require('express'),
    connect = require('connect'),
    sys = require('sys');
        
/**
 * Setup
 */
var pub = __dirname + '/public';

var app = express.createServer();

app.configure(function(){ 
    app.use(connect.bodyParser()); 
    app.use(connect.methodOverride()); 
    app.use(connect.static(pub));
});

//app.register('.haml', haml);
app.set('views', __dirname + '/views')
app.set('view engine', 'jade');


var PageProvider = require('./pageprovider').PageProvider;
var pageProvider = new PageProvider();

var UserProvider = require('./userprovider').UserProvider;
var userProvider = new UserProvider();

var PageMaker = require('./pagemaker').PageMaker;
var pagemaker = new PageMaker();

//for development
userProvider.checkUser('mdl', 'mdl',  function(err, user) {
    if(user == undefined){
       userProvider.save({'email':'mdl', 'password':'mdl'});
    }
});




// === agenda crud  ===
app.get('/agenda/:userid/:name', function(req, res){
    pageProvider.findByUseridAndName(req.params.userid, req.params.name, function(error, data){
        if(data != null) {
            res.send(JSON.stringify(data), { 'Content-Type': 'application/json' }, 200);            
        } else {
            res.send(null, 404);                        
        }
    })
})
app.get('/isnameok/:name/:id', function(req, res){
    pageProvider.isNameOK(req.params.name, req.params.id, function(error, data){
        if(data != null) {
            res.send(JSON.stringify(data), { 'Content-Type': 'application/json' }, 200);            
        } else {
            res.send(null, 404);                        
        }
    })
})
app.post('/agenda', function(req, res){
    try {
        var data = JSON.parse(req.rawBody);           
        pageProvider.save(data, function(error, data2) {
            var json = JSON.stringify(data2); //hexes the id
            res.send(json, 200);     
        });
    } catch(exc) {
        console.log('exception during post ' + exc);
        res.send("", 404);
    }
});

// === mobile client  ===

//Serves the mobile jquery mobile client
app.get('/m/:name', function(req, res){   
    pageProvider.findByName(req.params.name, function(error, data){
        if(data != null) {
            res.render('indexjqmobile.jade', {
              layout: false,
              rootpage: data.rootpage,
              pages: pagemaker.pages(data)
            })
        } else {
            res.send(null, 404);                        
        }
    })
})


//Serves the mobile client preview. 
//Not by name because it might have been changed. 
app.get('/prev/:id', function(req, res){   
    pageProvider.findById(req.params.id, function(error, data){
        if(data != null) {
            res.render('indexjqmobile.jade', {
              layout: false,
              rootpage: data.rootpage,
              pages: pagemaker.pages(data)
            })
        } else {
            res.send(null, 404);                        
        }
    })

})

//Serves the empty preview
app.get('/preview', function(req, res){
    res.render('emptypreview.jade', {
      layout: false
    })
})

//Serves the agenda data as JSON for the mobile client 
//FIXME why not use get('/agenda/*' just because auf "var data"
app.get('/data/:name', function(req, res){
    pageProvider.findByName(req.params.name, function(error, data){
        if(data != null) {
            res.send('var data = ' + JSON.stringify(data), { 'Content-Type': 'application/json' }, 200);            
        } else {
            res.send(null, 404);                        
        }
    })
})


// === user crud  ===
app.get('/user/:email/:password', function(req, res){
    userProvider.checkUser(req.params.email, req.params.password, function(err, data){
        var result = "undefined";
        if(data) {
            result = JSON.stringify(data);
        }
        res.send(result, { 'Content-Type': 'application/json' }, 200);            
    })
});
app.post('/password', function(req, res){
    try {
        var data = JSON.parse(req.rawBody);    
        var oldpassword = data.oldpassword;       
        var newpassword = data.newpassword;       
        var username = data.user;       
        userProvider.updatePassword(username, oldpassword, newpassword, function(err, data){
            var result = true;
            res.send({ 'changed': JSON.stringify(result) }, { 'Content-Type': 'application/json' }, 200);            
        });
    } catch(exc) {
        console.log('exception during post ' + exc);
        res.send("", 404);
    }
});
app.get('/admin/:adminpassword', function(req, res){
    if(req.params.adminpassword == 'sehrgeheim123') {
        userProvider.getCollection(function(err, users_collection) {
            users_collection.find({}, function(err, cursor) {
                cursor.toArray(function(err, users) {
                    res.render('admin.jade', {
                      layout: false,
                      users: users
                    })
                })
            });  
        });
    } else {
        res.send("Nope", 200);                     
    }
})
app.post('/admin/create_secret_user', function(req, res){
    userProvider.checkUser(req.body.email, req.body.password, function(err, user){
        var result = "undefined";
        if(user == undefined) {
            userProvider.save({'email':req.body.email, 'password':req.body.email}, function(err, saved_user) {
                if(err) res.send("Couldn't create user", 200);
                res.send("Created user " + saved_user.email, 200);                
            });
            
        } else {
            res.send("Couldn't create user ", 200);                     
        }
    })
})

exports.app = app;
exports.pageProvider = pageProvider;

