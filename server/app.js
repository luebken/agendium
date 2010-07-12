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
    pageProvider.findByName(name, function(error, docs){
        self.contentType('json');
        if(docs != null) {
            self.respond(200, JSON.stringify(docs));            
        } else {
            self.respond(404, null);                        
        }
    })
})

post('/agenda', function(){
  var self = this;
  var data = JSON.parse(this.body); 
  sys.print("saving:\n");
  sys.print(" data.id:"  + data.id + "\n");
  sys.print(" data.rootpage.title:"  + data.rootpage.title + "\n");
  if(data.rootpage.children && data.rootpage.children.length > 0 ) {
      sys.print(" data.rootpage.children[0].title:"  + data.rootpage.children[0].title + "\n");
  }
  pageProvider.save(data, function(error, docs) {
     self.respond(200, '');
  });
});

run();