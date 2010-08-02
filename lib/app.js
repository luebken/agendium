/**
 * Module dependencies.
 */

var express = require('express'),
    connect = require('connect');

// Path to our public directory
var pub = __dirname + '/public';

var app = express.createServer();
app.configure(function(){ 
    app.use(connect.bodyDecoder()); 
    app.use(connect.methodOverride()); 
    app.use(connect.staticProvider(pub));
});
app.set('views', __dirname + '/views')



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
app.post('/agenda', function(req, res){
  var data = JSON.parse(req.rawBody); 
  console.log("receiving children " + data.rootpage.children.length);
  
  pageProvider.save(data, function(error, data2) {
    console.log("returning children " + data2.rootpage.children.length);
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



var port = parseInt(process.env.PORT || 8000);
app.listen(port, null);
console.log('Server listening on ' + port);