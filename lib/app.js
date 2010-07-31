/**
 * Module dependencies.
 */

var express = require('express'),
    connect = require('connect');

// Path to our public directory

var app = express.createServer();
app.configure(function(){ 
    app.use(connect.bodyDecoder()); 
    app.use(connect.methodOverride()); 
    app.use(app.router); 
});


var PageProvider = require('./pageprovider-memory').PageProvider;
var pageProvider= new PageProvider();


app.put('/agenda', function(req, res){
    for(var key in req.headers) {
        console.log('key: ' + key + ' ' + req.headers[key]);                             
    }
    console.log('req.body: ' + req.body);
    console.log('req.params.body: ' + req.params.body);
  
  //var data = JSON.parse(req.body); 
  //pageProvider.save(data, function(error, data2) {
  //  res.send(JSON.stringify(data2), 200);            
  //});
    res.send("null", 200);
});


app.listen(parseInt(process.env.PORT || 8000), null);