require.paths.unshift('./lib/');
require('express')
require('express/plugins')
sys = require('sys')

//FIXME: MongoDB Implementierung einbinden
//var ArticleProvider= require('./articleprovider-mongodb').ArticleProvider;
var PageProvider = require('./pageprovider-memory').PageProvider;

configure(function(){
  use(MethodOverride);
  use(ContentLength);
  use(Logger);
  use(Static);
  set('root', __dirname);
})

var pageProvider= new PageProvider();

//Serves the agenda data as JSON for the desktop client 
get('/agenda/*', function(name){
    var self = this;
    pageProvider.findByName(name, function(error, data){
        self.contentType('json');
        if(data != null) {
            self.respond(200, JSON.stringify(data));            
        } else {
            self.respond(404, null);                        
        }
    })
})

//Saves the agenda from the desktop client. Accepts JSON
post('/agenda', function(){
  var self = this;
  var data = JSON.parse(this.body); 
  pageProvider.save(data, function(error, data2) {
      self.respond(200, JSON.stringify(data2));            
  });
});

//Serves the mobile client
get('/a/*', function(id){
    var idx = pageProvider.findIndexById(id);
    var data = pageProvider.dummyData[idx];    
    var self = this;
    this.render('index.html.haml', {
      layout: false,
      locals: {
        appid: id,
        rootpage: data.rootpage
      }
    })
})

//Serves the agenda data as JSON for the mobile client 
//FIXME why not use get('/agenda/*' just because auf "var data"
get('/data/*', function(name){
    var self = this;
    pageProvider.findByName(name, function(error, data){
        self.contentType('json');
        if(data != null) {
            self.respond(200, 'var data = ' + JSON.stringify(data));            
        } else {
            self.respond(404, null);                        
        }
    })
})

/*
get('/*.css', function(file){
  this.render(file + '.css.sass', { layout: false })
})
*/


run();