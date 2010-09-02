//var http = require('http')
// app = require('../lib/app').app;
 
var UserProvider = require('../lib/userprovider').UserProvider;
var userProvider = new UserProvider();

module.exports = {
     'test setup': function(assert, beforeExit){
         assert.isNotNull(userProvider);
     }, 
     'test connect': function(assert, beforeExit){
         console.log('test connect');
         userProvider.connect(function(db) {
              assert.isNotNull(db);
              assert.isDefined(db);
         });
     }, 
     'test checkUser': function(assert, beforeExit){
         userProvider.checkUser('mdl', function(result) {
             assert.isNotNull(result);
             assert.isDefined(result);
             assert.equal('true', result.toString());
         });
         userProvider.checkUser('anunknownuser', function(result) {
             assert.isNotNull(result);
             assert.isDefined(result);
             assert.equal('false', result.toString());
         });
      },
      'test getCollection2': function(assert, beforeExit){
          userProvider.getCollection(function(error, page_collection) {
              assert.isNull(error);
              assert.isDefined(page_collection);
              assert.equal('users', page_collection.collectionName);
              page_collection.count(function(error, n) {
                  assert.equal("1", n);                 
              });
          });
       }
}