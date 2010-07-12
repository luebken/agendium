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
get('/', function(){
  var self = this;
  pageProvider.findAll(function(error, docs){
      self.contentType('json');
      self.respond(200, JSON.stringify(docs));
  })
})

post('/new', function(){
  var self = this;
  var data = JSON.parse(this.body); 
  sys.print("saving "  + data.id);
  self.respond(200, '');
  /*
  articleProvider.save({
    title: this.param('title'),
    body: this.param('body')
  }, function(error, docs) {
    self.redirect('/')
  });
  */
});

run();