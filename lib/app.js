/**
 * Module dependencies.
 */

var express = require('express'),
    connect = require('connect');

// Path to our public directory

var pub = __dirname + '/public';

// Auto-compile sass to css with "compiler"
// and then serve with connect's staticProvider

var app = express.createServer(
    connect.compiler({ src: pub, enable: ['sass'] }),
    connect.staticProvider(pub)
    //connect.errorHandler({ showStack: true, dumpExceptions: true }),
    //connect.logger()
);

// Optional since express defaults to CWD/views

app.set('views', __dirname + '/views');

// Enable auto-reloading of view contents when changed
// with an interval of 1000 milliseconds. Start the app
// with $ node examples/jade/app.js
// then alter some views :)

app.set('reload views', 1000);
// or app.enable('reload views'); for defaults

// Set our default template engine to "jade"
// which prevents the need for extensions (although you can still mix and match)
app.set('view engine', 'jade');

var PageProvider = require('./pageprovider-memory').PageProvider;
var pageProvider= new PageProvider();

// === agenda crud  ===
app.get('/agenda/:name', function(req, res){
    pageProvider.findByName(req.params.name, function(error, data){
        if(data != null) {
            res.send(JSON.stringify(data), { 'Content-Type': 'application/json' }, 200);            
        } else {
            res.send(null, 404);                        
        }
    })
})
app.post('/agenda', function(){
  var self = this;
  var data = JSON.parse(this.body); 
  pageProvider.save(data, function(error, data2) {
      self.respond(200, JSON.stringify(data2));            
  });
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
app.get('/data/:name', function(req, res){
    pageProvider.findByName(req.params.name, function(error, data){
        if(data != null) {
            res.send('var data = ' + JSON.stringify(data), { 'Content-Type': 'application/json' }, 200);            
        } else {
            res.send(null, 404);                        
        }
    })
})

// === static files ===

/*
app.get('/public/themes/jqt/:file', function(req, res){
    res.sendfile('public/themes/jqt/' + req.params.file); 
});
app.get('/public/js/:file', function(req, res){
    res.sendfile('public/js/' + req.params.file); 
});
app.get('/css/:file', function(req, res){
    res.sendfile('public/css/' + req.params.file); 
});
app.get('/images/:file', function(req, res){
    res.sendfile('public/images/' + req.params.file); 
});
app.get('/:file', function(req, res){
    res.sendfile('public/' + req.params.file); 
});
app.get('/', function(req, res){ 
    res.sendfile('public/index.html'); 
});
*/

app.listen(parseInt(process.env.PORT || 8000), null);