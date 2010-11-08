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

app.configure(function(){ 
    app.use(connect.bodyDecoder()); 
    app.use(connect.methodOverride()); 
    app.use(connect.staticProvider(pub));
});
app.set('views', __dirname + '/views')

var PageProvider = require('./pageprovider').PageProvider;
var pageProvider = new PageProvider();

var UserProvider = require('./userprovider').UserProvider;
var userProvider = new UserProvider();

var PageMaker = require('./pagemaker').PageMaker;
var pagemaker = new PageMaker();

var SenchaDataMaker = require('./senchadatamaker').SenchaDataMaker;
var senchadatamaker = new SenchaDataMaker();


//for development

/*
userProvider.checkUser('mdl', '',  function(found) {
    if(!found){
        userProvider.save([{'email':'mdl', 'password':'mdl'}]);
    }
});
*/








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
//
app.get('/a/cache.manifest.:name', function(req, res) {
    console.log('cache.manifest.' + req.params.name);
    var data = "CACHE MANIFEST\n";
    data += "#savepoint 1\n";
    data += "../js/jqtouch.js\n";
    data += "../js/jquery-1.4.2.min.js\n";
    data += "../js/jqtouch.js\n";
    data += "../js/app.js\n";
    data += "../js/jqtouch.css\n";
    data += "../js/app.css\n";
    data += "../themes/jqt/theme.css\n";
    data += "../themes/jqt/img/toolbar.png\n";
    data += "../themes/jqt/img/activeButton.png\n";
    data += "../themes/jqt/img/button.png\n";
    data += "../themes/jqt/img/grayButton.png\n";
    data += "../themes/jqt/img/button_clicked.png\n";
    data += "../themes/jqt/img/back_button.png\n";
    data += "../themes/jqt/img/back_button_clicked.png\n";
    data += "../themes/jqt/img/chevron.png\n";
    data += "NETWORK:\n";
    data += "../data/"+req.params.name+"\n";
    res.send(data, { 'Content-Type': 'text/cache-manifest' }, 200); 
    
})

//Serves the mobile jqtouch client
app.get('/a/:name', function(req, res){    
    pageProvider.findByName(req.params.name, function(error, data){
        if(data != null) {
            res.render('index.html.haml', {
              layout: false,
              locals: {
                rootpage: data.rootpage
              }
            })
        } else {
            res.send(null, 404);                        
        }
    })
})
//Serves the mobile jquery mobile client
app.get('/m/:name', function(req, res){   
    pageProvider.findByName(req.params.name, function(error, data){
        if(data != null) {
            res.render('index2.html.haml', {
              layout: false,
              locals: {
                rootpage: data.rootpage,
                pages: pagemaker.pages(data)
              }
            })
        } else {
            res.send(null, 404);                        
        }
    })
})

//Serves the mobile jquery mobile client
app.get('/s/:name', function(req, res){   
    pageProvider.findByName(req.params.name, function(error, data){
        if(data != null) {
            res.render('indexsencha.html.haml', {
              layout: false,
              locals: {
                rootpage: data.rootpage,
                setdataurl: "DATA_URL='/senchadata/"+data.rootpage.title+"';",
                settitle: "TITLE='"+data.rootpage.title+"';"
              }
            })
        } else {
            res.send(null, 404);                        
        }
    })
})

app.get('/senchadata/:name', function(req, res){
    pageProvider.findByName(req.params.name, function(error, data){
        if(data != null) {
            res.send(senchadatamaker.make(data), { 'Content-Type': 'application/json' }, 200);            
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
            res.render('index2.html.haml', {
              layout: false,
              locals: {
                rootpage: data.rootpage,
                pages: pagemaker.pages(data)
              }
            })
        } else {
            res.send(null, 404);                        
        }
    })

})

//Serves the empty preview
app.get('/preview', function(req, res){
    res.render('emptypreview.html.haml', {
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
})

exports.app = app;
exports.pageProvider = pageProvider;

