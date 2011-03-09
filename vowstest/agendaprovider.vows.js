require.paths.unshift('vendor/testlib');
require.paths.unshift('vendor/lib');
require.paths.unshift('lib');

var vows = require('vows'),
    assert = require('assert'),
    http = require('http');

var AgendaProvider = require('controller/agenda/agendaprovider').AgendaProvider;
var agendaProvider = new AgendaProvider();

vows.describe('agendaprovider')
.addBatch({
    'app is configured': {
        topic: function() { return agendaProvider },
        'app is not null': function (agendaProvider) {
            assert.isNotNull(agendaProvider);
        }
    },
    'database connection works': {
        topic: function() { agendaProvider.connect(this.callback); },
        'db is not null': function(db, db2) {
            assert.isNotNull(db);
            assert.isDefined(db);
            assert.isNotNull(agendaProvider.db);
            assert.equal(db, agendaProvider.db);
        }
    }
})
.addBatch({
    'collection creation': {
        topic: function() { agendaProvider.getCollection(this.callback)},
        'collection returned and has the right name': function (error, agenda_collection) {
            assert.isNull(error);
            assert.equal('agenda', agenda_collection.collectionName);
        }
    },
    'collection is empty': {
        topic: function() { 
            var self = this;
            agendaProvider.removeAll(function() {
                agendaProvider.getCollection( function(error, agenda_collection) {
                    agenda_collection.count(error, self.callback);
                });
            });
        },
        'collection has no entries': function (error, n) {
            assert.equal(0, n);
        }
    }
})
.addBatch({
    'test initially cant find by id': {
        topic: function() { 
            var self = this;
            agendaProvider.removeAll(function() {
                agendaProvider.findById('1', self.callback) 
            });
        },
        'result empty': function (error, agenda) {
            assert.isNull(error);
            assert.isUndefined(agenda);
        }
    }
})
.addBatch({
    'test initially cant find by name': {
        topic: function() { 
            var self = this;
            agendaProvider.removeAll(function() {
                agendaProvider.findByName('appname', self.callback) 
            });
        },
        'result empty': function (error, agenda) {
            assert.isNull(error);
            assert.isUndefined(agenda);
        }
    }
})
.addBatch({
    'initial save works': {
        topic: function() { 
            var self = this;
            agendaProvider.removeAll(function() {
                agendaProvider.save({'name':'hurz', '_id':'undefined', 'userid':'123'}, self.callback ) 
            });
        },
        'no error and inserted agenda is fine': function (error, inserted_agenda) {
            assert.isNull(error);
            assert.equal(inserted_agenda.name, 'hurz');
            assert.equal(inserted_agenda.userid, '123');
            assert.isDefined(inserted_agenda._id);    
        }    
    }
})
.addBatch({
    'save doesnt work because of missing userid': {
        topic: function() { 
            var self = this;
            agendaProvider.removeAll(function() {
                agendaProvider.save({'name':'hurz828', '_id':'undefined'}, self.callback ) 
            });
        },
        'error and no inserted agendax': function (error, inserted_agenda) {
            //assert.isNotNull(error);
            //assert.isNotNull(error);
            //assert.notStrictEqual(undefined, inserted_agenda);
        }    
    }
})
.addBatch({ 
    'update works': {
        topic: function() { 
            var self = this;
            agendaProvider.removeAll(function() {
                agendaProvider.save({'name':'hurz', '_id':'undefined', 'userid':'123'}, function(error, inserted_agenda) {
                    agendaProvider.save({'name':'schnurz', '_id':inserted_agenda._id.toHexString(), 'userid':'123'}, self.callback );
                }); 
            });
        },
        'no error and inserted agenda is fine': function (error, inserted_agenda) {
            assert.isNull(error);
            assert.equal(inserted_agenda.name, 'schnurz');
            assert.equal(inserted_agenda.userid, '123');
            assert.isDefined(inserted_agenda._id);

        }
    }
})
.addBatch({
    'test find by id after save': {
        topic: function() { 
            var self = this;
            agendaProvider.removeAll(function() {
                agendaProvider.save({'name':'hurz', '_id':'undefined', 'userid':'123'}, function(error, inserted_agenda) {
                    agendaProvider.findById(inserted_agenda._id.toHexString(), self.callback);
                }); 
            });
        },
        'result not empty': function (error, agenda) {
            assert.isNull(error);
            assert.isDefined(agenda);           
        }
    }
})
.addBatch({
    'test find by name after save': {
        topic: function() { 
            var self = this;
            agendaProvider.removeAll(function() {
                agendaProvider.save({'rootpage':{'title': 'hurx'}, '_id':'undefined', 'userid':'123'}, function(error, inserted_agenda) {
                    agendaProvider.findByName('hurx', self.callback);
                }); 
            });
        },
        'result not empty without id': function (error, agenda) {
            assert.isNull(error);
            assert.isDefined(agenda);
            assert.isNull(agenda.userid); 
        }
    }
})
.addBatch({
    'test find by name with capitals': {
        topic: function() { 
            var self = this;
            agendaProvider.removeAll(function() {
                agendaProvider.save({'rootpage':{'title': 'neu'}, '_id':'undefined', 'userid':'123'}, function(error, inserted_agenda) {
                    agendaProvider.findByName('NEU', self.callback);
                }); 
            });
        },
        'result not empty': function (error, agenda) {
            assert.isNull(error);
            assert.isDefined(agenda.rootpage.title);
            assert.equal('neu', agenda.rootpage.title);
        }
    }
})
.addBatch({
    'name is ok because its not found': {
        topic: function() { 
            var self = this;
            agendaProvider.isNameOK('einnichtvorhandenername', '123', self.callback);
        },
        'result is true': function (error, result) {
            assert.isNull(error);
            assert.isTrue(result);
        }
    }
})
.addBatch({
    'name is ok because its found and its id is equal': {
        topic: function() { 
            var self = this;
            agendaProvider.removeAll(function() {
                agendaProvider.save({'rootpage':{'title': 'neu'}, '_id':'undefined', 'userid':'123'}, function(error, inserted_agenda) {
                    agendaProvider.isNameOK('neu', inserted_agenda._id.toHexString(), self.callback);
                }); 
            });        
        },
        'result is true': function (error, result) {
            assert.isNull(error);
            assert.isTrue(result);
        }
    }
})
.addBatch({
    'test name is not ok because its found and it id is not equal': {
        topic: function() { 
            var self = this;
            agendaProvider.removeAll(function() {
                agendaProvider.save({'rootpage':{'title': 'neu'}, '_id':'undefined', 'userid':'123'}, function(error, inserted_agenda) {
                    agendaProvider.isNameOK('neu', '123', self.callback);
                }); 
            });        
        },
        'result is true': function (error, result) {
            assert.isNull(error);
            assert.isFalse(result);
        }
    }
})
.addBatch({
    'database connection closed': {
        topic: function() { agendaProvider.close(); return null;},
        'db is not null': function() {
            assert.isNull(agendaProvider.db);
        }
    }
})

.export(module)