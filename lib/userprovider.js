var Db = require('mongodb').Db;
var mongoconnect = require('mongodb').connect;
var ObjectID = require('mongodb/bson/bson').ObjectID;
var Server = require('mongodb/connection').Server;
var url = require('url');
//
// Custom API
//
UserProvider = function(){

};
UserProvider.prototype.connect= function(callback) {
    var url;
    if(process.env['MONGOHQ_URL'] === undefined) {
        url = 'mongodb://localhost:27017/agendium';          
    } else {
        url = process.env['MONGOHQ_URL'];
    }
    mongoconnect(url, function(err, db){
        callback(db);
    });
}


UserProvider.prototype.getCollection= function(callback) {
    this.connect(function(db) {
        db.collection('users', function(error, users_collection) {
            if( error ) callback(error);
            else callback(null, users_collection);
        });
    });
};

UserProvider.prototype.checkUser = function(email2, callback) {
    console.log('checking user ' + email2);
    this.getCollection(function(error, users_collection) {
      if( error ) console.log(error)
      else {
        users_collection.findOne({email: email2}, function(error, result) {
          if( error ) callback(error)
          else callback(result != undefined)
        });
      }
    });
};

UserProvider.prototype.save = function(users) {
    this.getCollection(function(error, users_collection) {
      if( error ) console.log(error)
      else {
        users_collection.insert(users, function() {
            console.log('inserting users: ' + users[0].email)
        });
      }
    });
};


exports.UserProvider = UserProvider;