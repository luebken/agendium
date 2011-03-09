require.paths.unshift("./vendor/lib");

var Db = require('mongodb').Db,
    mongoconnect = require('mongodb').connect,
    ObjectID = require('mongodb/bson/bson').ObjectID,
    Server = require('mongodb/connection').Server,
    url = require('url'),
    crypto = require('crypto');

var encryptPassword = function(password) {
    return crypto.createHmac('sha1', 'sd87dc8c7wlsod80').update(password).digest('hex');
}

UserProvider = function(){
    this.db = null;
};

UserProvider.prototype.connect = function(callback) {
    var self = this;
    if(self.db) {
        callback(self.db);
    } else {
        var url = process.env['MONGOHQ_URL'];
        if(!url) throw new Error('No MONGOHQ_URL defined!');
        console.log('Using url ' + url);
        mongoconnect(url, function(err, db){
            self.db = db;
            callback(db);
        });        
    }
}
UserProvider.prototype.close = function() {
    this.db.close();
    this.db = null;
}

UserProvider.prototype.getCollection = function(callback) {
    this.connect(function(db) {
        db.collection('users', function(error, users_collection) {
            if( error ) {
                callback(error);  
            } else {
                callback(null, users_collection);  
            } 
        });
    });
};


UserProvider.prototype.checkUser = function(email2, password2, callback) {
    console.log('checking user ' + email2);
    this.getCollection(function(error, users_collection) {
        if (error) {
            console.log('error:' + error)
            callback(error, null);
        } else {
            var hashedpassword2 = encryptPassword(password2);
            users_collection.findOne({email: email2, hashedpassword: hashedpassword2}, function(error, result) {
                if (error) {
                    console.log('error:' + error)
                    callback(error, null);
                } else {
                    callback(null, result)
                }
            });
        }
    });
};

UserProvider.prototype.save = function(user, callback) {
    this.getCollection(function(error, users_collection) {
        if (error) console.log(error)
        else {
            user.hashedpassword = encryptPassword(user.password);
            users_collection.insert([user], function(err, inserted_data) {
                if(inserted_data.length > 1) callback('Error while inserting data. To many ' + inserted_data.length, null);
                console.log('inserted users: ' + inserted_data[0].email);
                callback(err, inserted_data[0]);
            });
        }
    })
};

UserProvider.prototype.updatePassword = function(email, oldpassword, newpassword, callback) {
    this.getCollection(function(error, users_collection) {
        if (error) console.log(error)
        else {
            var old_hashedpassword = encryptPassword(oldpassword);
            var new_hashedpassword = encryptPassword(newpassword);          
            var spec = {'email':email, 'hashedpassword':old_hashedpassword};
            var doc = {$set:{'hashedpassword':new_hashedpassword}};
            users_collection.update(spec, doc, undefined ,function(err, inserted_data) {
                callback(err, inserted_data);
            });
        }
    });
};

UserProvider.prototype.removeAll = function(callback) {
    this.getCollection(function(error, users_collection) {
        if( users_collection ) users_collection.remove();
        callback();
    });
};

exports.UserProvider = UserProvider;