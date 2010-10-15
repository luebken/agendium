require.paths.unshift('vendor/testlib');

var vows = require('vows'),
    assert = require('assert'),
    http = require('http');
    
var ImpressionsProvider = require('../lib/impressionsprovider').ImpressionsProvider;
var impressionsprovider = new ImpressionsProvider();

vows.describe('impressionsprovider')
.addBatch({
    'app is configured': {
        topic: function(){ return impressionsprovider },
        'app is not null': function (impressionsprovider) {
            assert.isNotNull (impressionsprovider);
        }
    }
})
.addBatch({
    'collection creation': {
        topic: function() { impressionsprovider.getCollection(this.callback)},
        'collection returned and has the right name': function (error, impressions_collection) {
            assert.isNull(error);
            assert.equal('impressions', impressions_collection.collectionName);
        }
    }
})
.addBatch({
    'collection is empty': {
        topic: function() { 
            var self = this;
            impressionsprovider.removeAll(function() {
                impressionsprovider.getCollection( function(error, impressions_collection) {
                    impressions_collection.count(error, self.callback);
                });
            });
        },
        'collection has no entries': function (error, n) {
            assert.equal(n, 0);
        }
    }
})
.addBatch({
    'test initially no impressions': {
        topic: function() { 
            var self = this;
            impressionsprovider.removeAll(function() {
                impressionsprovider.count('123', self.callback) 
            });
        },
        'result empty': function (error, count) {
            assert.isNull(error);
            assert.equal(count, "0");
        }
    }
})
.addBatch({
    'initial save works': {
        topic: function() { 
            var self = this;
            impressionsprovider.removeAll(function() {
                impressionsprovider.start("123", self.callback ) 
            });
        },
        'no error and inserted impression is fine': function (error, inserted_impression) {
            assert.equal(inserted_impression[0].pageid, '123');
            assert.equal(inserted_impression[0].count, 0);
            assert.isDefined(inserted_impression[0]._id);            
        }    
    }
})
.addBatch({
    'inkrement works': {
        topic: function() { 
            var self = this;
            impressionsprovider.inc("123", function () {
                impressionsprovider.inc('123', function () {
                    impressionsprovider.count('123', self.callback) 
                });
            });
        },
        'no error and inserted impression is fine': function (error, count) {
            assert.isNull(error);
            assert.equal(count, 2);        
        }    
    }
})
.addBatch({
    'database connection closed': {
        topic: function() { impressionsprovider.close(); return null;},
        'db is not null': function() {
            assert.isNull(impressionsprovider.db);
        }
    }
})
.export(module)