require.paths.unshift('./lib/');
require('express')
require('express/plugins')
sys = require('sys')

//var ArticleProvider= require('./articleprovider-mongodb').ArticleProvider;
var PageProvider = require('./pageprovider-memory').PageProvider;

configure(function(){
  use(MethodOverride);
  use(ContentLength);
  use(Logger);
  set('root', __dirname);
})

var pageProvider= new PageProvider();
get('/agenda/*', function(name){
    sys.print("get('/agenda/"+name+")");
    var self = this;
    pageProvider.findByName(name, function(error, data2){
        self.contentType('json');
        if(data2 != null) {
            self.respond(200, JSON.stringify(data2));            
        } else {
            self.respond(404, null);                        
        }
    })
})

post('/agenda', function(){
  var self = this;
  var data = JSON.parse(this.body); 
  pageProvider.save(data, function(error, data2) {
      self.respond(200, JSON.stringify(data2));            
  });
});

run();