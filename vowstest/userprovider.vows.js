require.paths.unshift('vendor/testlib');
require.paths.unshift('vendor/lib');
require.paths.unshift('lib');


var vows = require('vows'),
    assert = require('assert'),
    http = require('http');
    
var UserProvider = require('controller/user/userprovider').UserProvider;
var userprovider = new UserProvider();

vows.describe('userprovider')
.addBatch({
    'app is configured': {
        topic: function(){ return userprovider },
        'app is not null': function (userprovider) {
            assert.isNotNull (userprovider);
        }
    }
})

.addBatch({
    'collection creation': {
        topic: function() { userprovider.getCollection(this.callback)},
        'collection returned and has the right name': function (error, user_collection) {
            assert.isNull(error);
            assert.equal('users', user_collection.collectionName);
        }
    }
})
.addBatch({
    'collection is empty': {
        topic: function() { 
            var self = this;
            userprovider.removeAll(function() {
                userprovider.getCollection( function(error, user_collection) {
                    user_collection.count(error, self.callback);
                });
            });
        },
        'collection has no entries': function (error, n) {
            assert.equal(n, 0);
        }
    }
})

.addBatch({
    'test initially checkuser false': {
        topic: function() { 
            var self = this;
            userprovider.removeAll(function() {
                userprovider.checkUser('mdl','', self.callback) 
            });
        },
        'result empty': function (error, user) {
            assert.isNull(error);
            assert.isTrue(user == undefined);
        }
    }
})


.addBatch({
    'initial save works': {
        topic: function() { 
            var self = this;
            userprovider.removeAll(function() {
                userprovider.save({'email':'hurz', 'password':'secure'}, self.callback ) 
            });
        },
        'no error and inserted user is fine': function (error, inserted_user) {
            assert.equal(inserted_user.email, 'hurz');
            //assert.isNull(inserted_user.password);
            assert.equal('accdb4e36c16fdf25eba520f3efb15219f02dd4a',inserted_user.hashedpassword);
            assert.isDefined(inserted_user._id);            
        }    
    }
})



.addBatch({
    'checkuser with wrong password': {
        topic: function() { 
            var self = this;
            userprovider.removeAll(function() {
                userprovider.save({'email':'hurz2', 'password':'secure'}, function (error, inserted_users) {
                    userprovider.checkUser('hurz2', 'sdfsd', self.callback) 
                } ) 
            });
        },
        'no error and user is false': function (error, user) {
            assert.isNull(error);
            assert.isUndefined(user);          
        }    
    }
})

.addBatch({
    'checkuser with correct password': {
        topic: function() { 
            var self = this;
            userprovider.removeAll(function() {
                userprovider.save({'email':'hurz3', 'password':'secure'}, function (error, inserted_users) {
                    userprovider.checkUser('hurz3', 'secure', self.callback) 
        
                } ) 
            });
        },
        'no error and user is fine': function (error, user) {
            assert.isNull(error);
            assert.isDefined(user);     
            assert.equal('hurz3', user.email);  
            assert.equal('secure', user.password);
        }    
    }
})


.addBatch({
    'update password': {
        topic: function() { 
            var self = this;
            userprovider.removeAll(function() {
                userprovider.save({'email':'hurz3', 'password':'secure'}, function (error, inserted_users) {
                    userprovider.updatePassword('hurz3', 'secure', 'reallysecure', function () {
                        userprovider.checkUser('hurz3', 'reallysecure', self.callback) 
                    }) 
                } ) 
            });
        },
        'no error and user is fine': function (error, user) {
            assert.isNull(error);
            assert.isTrue(user != undefined);     
            assert.equal('hurz3', user.email);  
            assert.equal('6a517f4dc223b4be157f5c4a7d6c06d09a5778ed', user.hashedpassword);
        }    
    }
})

.addBatch({
    'didnt update password': {
        topic: function() { 
            var self = this;
            userprovider.removeAll(function() {
                userprovider.save({'email':'hurz3', 'password':'secure'}, function (error, inserted_users) {
                    userprovider.updatePassword('hurz3', 'secure2', 'reallysecure', function () {
                        userprovider.checkUser('hurz3', 'reallysecure', self.callback) 
                    })                
                } ) 
            });
        },
        'no error and user is fine': function (error, data) {
            assert.isNull(error);
            assert.isTrue(data == undefined);     
        }    
    }
})

.addBatch({
    'didnt update password': {
        topic: function() { 
            var self = this;
            userprovider.removeAll(function() {
                userprovider.save([{'email':'hurz3', 'password':'secure'}], function (error, inserted_users) {
                    userprovider.updatePassword('hurz3', 'secure2', 'reallysecure', self.callback)
                } ) 
            });
        },
        'no error and user is fine': function (error, data) {
            assert.isNull(error);
            //TODO wie siehe ich dass das update nicht geklappt hat?
            //assert.isTrue(data == undefined);     
        }    
    }
})


.addBatch({
    'database connection closed': {
        topic: function() { userprovider.close(); return null;},
        'db is not null': function() {
            assert.isNull(userprovider.db);
        }
    }
})
.export(module)