var sys = require('sys');
// app = require('../lib/app').app;
 
var PageProvider = require('../lib/pageprovider').PageProvider;
var pageProvider = new PageProvider();

module.exports = {
     'test setup': function(assert, beforeExit){
         assert.isNotNull(pageProvider);
     }, 
     'test connect': function(assert, beforeExit){
         pageProvider.connect(function(db) {
              assert.isNotNull(db);
              assert.isDefined(db);
         });
     },      
     'test initially empty collection': function(assert, beforeExit){
         pageProvider.removeAll();                                                           
         pageProvider.getCollection(function(error, page_collection) {             
             assert.isNull(error);
             assert.isDefined(page_collection);
             assert.equal('page', page_collection.collectionName);
             page_collection.count(function(error, n) {
                 assert.equal(0, n);                 
             });
         });
      },
      
      'test initially cant find by id': function(assert, beforeExit){
          pageProvider.findById('1', function(error, page) {
             assert.isNull(error);
             assert.isUndefined(page);
          });
       },
       'test save a page': function(assert, beforeExit) {     
           pageProvider.removeAll();                                  
           var page = {'name':'hurz'};
           pageProvider.save(page, function(error, inserted_page) {
               assert.isNull(error);
               assert.isDefined(inserted_page);
               assert.equal(inserted_page.name, 'hurz');
               assert.isDefined(inserted_page._id);
               console.log('inserted_page._id: ' + inserted_page._id.toHexString());
               pageProvider.getCollection(function(error, page_collection) {
                   page_collection.count(function(error, n) {
                       assert.equal(1, n);
                       pageProvider.removeAll();                 
                   });
               });
             });
       },
       'test find a page by id': function(assert, beforeExit) {     
           pageProvider.removeAll();                                  
           pageProvider.save({'name':'hurz'}, function(error, inserted_page) {
               var id = inserted_page._id.toHexString();
               pageProvider.findById(id, function(error, page) {
                  assert.isNull(error);
                  assert.isDefined(page);
                  assert.equal(page.name, 'hurz');
                  assert.notStrictEqual(page._id, id);
               });
           }); 
       }

}