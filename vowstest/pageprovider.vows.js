require.paths.unshift('vendor/testlib');

var vows = require('vows'),
    assert = require('assert'),
    http = require('http');
    
var PageProvider = require('../lib/pageprovider').PageProvider;
var pageProvider = new PageProvider();

vows.describe('app').addBatch({
    'app is configured': {
        topic: function(){return pageProvider},
        'app is not null': function (pageProvider) {
            assert.isNotNull (pageProvider);
        }
    },
    'database connection works': {
        topic: function() { pageProvider.connect(this.callback); },
        'db is not null': function(db, db2) {
            assert.isNotNull(db);
            assert.notStrictEqual(undefined, db);
            assert.isNotNull(pageProvider.database);
            assert.equal(db, pageProvider.database);
        }
    }
}).addBatch({
    'collection creation': {
        topic: function() { pageProvider.getCollection(this.callback)},
        'collection returned and has the right name': function (error, page_collection) {
            assert.isNull(error);
            assert.equal('page', page_collection.collectionName);
        }
    },
    'collection is empty': {
        topic: function() { 
            var self = this;
            pageProvider.removeAll(function() {
                pageProvider.getCollection( function(error, page_collection) {
                    page_collection.count(error, self.callback);
                });
            });
        },
        'collection has no entries': function (error, n) {
            assert.equal(0, n);
        }
    }
}).addBatch({
    'test initially cant find by id': {
        topic: function() { 
            var self = this;
            pageProvider.removeAll(function() {
                pageProvider.findById('1', self.callback) 
            });
        },
        'result empty': function (error, page) {
            assert.isNull(error);
            assert.isUndefined(page);
        }
    }
})
.addBatch({
    'test initially cant find by name': {
        topic: function() { 
            var self = this;
            pageProvider.removeAll(function() {
                pageProvider.findByName('appname', self.callback) 
            });
        },
        'result empty': function (error, page) {
            assert.isNull(error);
            assert.isUndefined(page);
        }
    }
}).addBatch({
    'initial save works': {
        topic: function() { 
            var self = this;
            pageProvider.removeAll(function() {
                pageProvider.save({'name':'hurz', '_id':'undefined'}, self.callback ) 
            });
        },
        'no error and inserted page is fine': function (error, inserted_page) {
            assert.isNull(error);
            assert.equal(inserted_page.name, 'hurz');
            assert.notStrictEqual(undefined, inserted_page._id);            
        }    
    }
}).addBatch({ 
    'update works': {
        topic: function() { 
            var self = this;
            pageProvider.removeAll(function() {
                pageProvider.save({'name':'hurz', '_id':'undefined'}, function(error, inserted_page) {
                     pageProvider.save({'name':'schnurz', '_id':inserted_page._id}, self.callback );
                }); 
            });
        },
        'no error and inserted page is fine': function (error, inserted_page) {
            assert.isNull(error);
            assert.equal(inserted_page.name, 'schnurz');
            assert.notStrictEqual(undefined, inserted_page._id);
        }
    }
}).addBatch({
    'test find by id after save': {
        topic: function() { 
            var self = this;
            pageProvider.removeAll(function() {
                pageProvider.save({'name':'hurz', '_id':'undefined'}, function(error, inserted_page) {
                    pageProvider.findById(inserted_page._id.toHexString(), self.callback);
                }); 
            });
        },
        'result not empty': function (error, page) {
            assert.isNull(error);
            assert.notStrictEqual(undefined, page);           
        }
    }
}).addBatch({
    'test find by name after save': {
        topic: function() { 
            var self = this;
            pageProvider.removeAll(function() {
                pageProvider.save({'rootpage':{'title': 'hurx'}, '_id':'undefined'}, function(error, inserted_page) {
                    pageProvider.findByName('hurx', self.callback);
                }); 
            });
        },
        'result not empty': function (error, page) {
            assert.isNull(error);
            assert.notStrictEqual(undefined, page);
        }
    }
}).addBatch({
    'test find by name with capitals': {
        topic: function() { 
            var self = this;
            pageProvider.removeAll(function() {
                pageProvider.save({'rootpage':{'title': 'neu'}, '_id':'undefined'}, function(error, inserted_page) {
                    pageProvider.findByName('neu', self.callback);
                }); 
            });
        },
        'result not empty': function (error, page) {
            assert.isNull(error);
            assert.notStrictEqual(undefined, page.rootpage.title);
            assert.equal('neu', page.rootpage.title);
        }
    }
}).addBatch({
    'name is ok because its not found': {
        topic: function() { 
            var self = this;
            pageProvider.isNameOK('einnichtvorhandenername', '123', self.callback);
        },
        'result is true': function (error, result) {
            assert.isNull(error);
            assert.equal(true, result);
        }
    }
})
.addBatch({
    'name is ok because its found and its id is equal': {
        topic: function() { 
            var self = this;
            pageProvider.removeAll(function() {
                pageProvider.save({'rootpage':{'title': 'neu'}, '_id':'undefined'}, function(error, inserted_page) {
                    pageProvider.isNameOK('neu', inserted_page._id.toHexString(), self.callback);
                }); 
            });        
        },
        'result is true': function (error, result) {
            assert.isNull(error);
            assert.equal(result, true);
        }
    }
})
.addBatch({
    'test name is not ok because its found and it id is not equal': {
        topic: function() { 
            var self = this;
            pageProvider.removeAll(function() {
                pageProvider.save({'rootpage':{'title': 'neu'}, '_id':'undefined'}, function(error, inserted_page) {
                    pageProvider.isNameOK('neu', '123', self.callback);
                }); 
            });        
        },
        'result is true': function (error, result) {
            assert.isNull(error);
            assert.equal(result, false);
        }
    }
})
.addBatch({
    'database connection closed': {
        topic: function() { pageProvider.close(); return null;},
        'db is not null': function() {
            assert.isNull(pageProvider.database);
        }
    }
})
.run();