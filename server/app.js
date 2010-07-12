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
  use(Static);
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

get('/a/*', function(id){
    var idx = pageProvider.findIndexById(id);
    var data = pageProvider.dummyData[0];
    sys.print("get('/a/" + id + ")\n");
    sys.print("idx:" + idx + "\n");
    sys.print("data:" + data + "\n");
    
    var self = this;
    this.render('index.html.haml', {
      locals: {
        appid: id,
        title: data.rootpage.title
      }
    })
})

/*
get('/*.css', function(file){
  this.render(file + '.css.sass', { layout: false })
})
*/


run();