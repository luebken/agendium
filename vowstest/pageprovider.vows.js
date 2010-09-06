require.paths.unshift('vendor/testlib');

var vows = require('vows'),
    assert = require('assert');    

var http = require('http'),
     //app = require('../lib/app').app,
     pageProvider = require('../lib/app').pageProvider;

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
    'collection size': {
        topic: function() { 
            var self = this;
            pageProvider.getCollection( function(error, page_collection) {
                assert.notStrictEqual(undefined, page_collection);
                page_collection.count(error, self.callback);
            });
        },
        'collection has no entries': function (error, n) {
            assert.equal(0, n);
        }
    }
}).addBatch({
    'test initially cant find by id': {
        topic: function() { pageProvider.findById('1', this.callback) },
        'result empty': function (error, page) {
            assert.isNull(error);
            assert.isUndefined(page);
        }
    }
}).addBatch({
    'saving': {
        topic: function() { pageProvider.save({'name':'hurz', '_id':'undefined'}, this.callback ) },
        'inserted page': function (error, inserted_page) {
            assert.isNull(error);
            assert.equal(inserted_page.name, 'hurz');
            assert.notStrictEqual(undefined, inserted_page._id);
            
            pageProvider.removeAll();
        }
    }
}).run();