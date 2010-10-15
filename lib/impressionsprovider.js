require.paths.unshift("./vendor/lib");

var Db = require('mongodb').Db;
var mongoconnect = require('mongodb').connect;
var ObjectID = require('mongodb/bson/bson').ObjectID;
var Server = require('mongodb/connection').Server;
var url = require('url');

ImpressionsProvider = function(){
    this.db = null;
};

ImpressionsProvider.prototype.connect = function(callback) {
    var self = this;
    var url = process.env['MONGOHQ_URL'] || 'mongodb://localhost:27017/agendium';
    if(self.db) {
        callback(self.db);
    } else {
        mongoconnect(url, function(err, db){
            self.db = db;
            callback(db);
        });        
    }
}
ImpressionsProvider.prototype.close = function() {
    this.db.close();
    this.db = null;
}

ImpressionsProvider.prototype.getCollection = function(callback) {
    this.connect(function(db) {
        db.collection('impressions', function(error, impressions_collection) {
            if( error ) {
                callback(error);  
            } else {
                callback(null, impressions_collection);  
            } 
        });
    });
};

ImpressionsProvider.prototype.removeAll = function(callback) {
    this.getCollection(function(error, impressions_collection) {
      if( impressions_collection ) impressions_collection.remove();
      callback();
    });
};

ImpressionsProvider.prototype.start = function(pageId2, callback) {
    this.getCollection(function(error, impressions_collection) {
      if( error ) console.log(error)
      else {
          var impressions = {pageid:pageId2, count:0}
          impressions_collection.insert(impressions, function(err, inserted_data) {
              callback(err, inserted_data);
          });
      }
    });
};

ImpressionsProvider.prototype.inc = function(pageid, callback) {
    this.getCollection(function(error, impressions_collection) {
      if( error ) callback(error);  
      else {
        impressions_collection.findOne({"pageid": pageid}, function(error, result) {
          if( error ) callback(error)
          else {
              result.count++;
              impressions_collection.save(result, function(error, saved_data) {            
                  callback(null, saved_data)
              });
          }
        });
      }
    });
};

ImpressionsProvider.prototype.count = function(pageid, callback) {
    this.getCollection(function(error, impressions_collection) {
      if( error ) console.log("err" + error)
      else {
          impressions_collection.findOne({"pageid": pageid}, function(error, result) {
            if( error ) callback(error)
            else callback(null, result ? result.count : 0);
          });
        }
    });
};




exports.ImpressionsProvider = ImpressionsProvider;