var Db = require('mongoose/lib/support/node-mongodb-native/lib/mongodb').Db;
var ObjectID = require('mongoose/lib/support/node-mongodb-native/lib/mongodb/bson/bson').ObjectID;
var Server = require('mongoose/lib/support/node-mongodb-native/lib/mongodb/connection').Server;
var url = require('url');
//
// Custom API
//
UserProvider = function(){
    var uristring;
    if(process.env['MONGOHQ_URL'] === undefined) {
        uristring = 'mongodb://localhost:27017/agendium';          
    } else {
        uristring = process.env['MONGOHQ_URL'];              
    }
    var uri = url.parse(uristring);
    console.log('Connecting to ' + uri.hostname + ':' + uri.port + '/' + uri.pathname );    
    this.db= new Db(uri.pathname, new Server(uri.hostname, uri.port, {auto_reconnect: true}, {}));
    this.db.open(function(){});
};


UserProvider.prototype.getCollection= function(callback) {
  this.db.collection('users', function(error, users_collection) {
    if( error ) callback(error);
    else callback(null, users_collection);
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