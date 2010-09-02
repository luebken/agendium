require.paths.unshift("./vendor/lib");

var Db = require('mongodb').Db;
var mongoconnect = require('mongodb').connect;
var ObjectID = require('mongodb/bson/bson').ObjectID;
var Server = require('mongodb/connection').Server;
var url = require('url');

PageProvider = function(){

};

PageProvider.prototype.connect = function(callback) {
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

PageProvider.prototype.getCollection = function(callback) {
    this.connect(function(db) {
        db.collection('page', function(error, pages_collection) {
            if( error ) {
                callback(error);   
            } else {
                callback(null, pages_collection);
            }
        });
    });
};

PageProvider.prototype.save = function(page, callback) {
    this.getCollection(function(error, page_collection) {
      if( error ) {
          callback(error)
      }
      else {
        console.log('inserting page._id:' + page._id);
        if(page._id === 'undefined') page._id = null; //WORKAROUND WHY???   
               
        page_collection.insertAll([page], function(error, inserted_pages) {
          callback(error, inserted_pages[0]);
        });
      }
    });
};

PageProvider.prototype.removeAll = function(callback) {
    this.getCollection(function(error, page_collection) {
      if( page_collection ) page_collection.remove();
    });
};


PageProvider.prototype.findById = function(id, callback) {
    this.getCollection(function(error, pages_collection) {
      if( error ) {
        callback(error);  
      } 
      else {
        pages_collection.findOne({_id: ObjectID.createFromHexString(id)}, function(error, result) {
          if( error ) callback(error)
          else callback(null, result)
        });
      }
    });
};


exports.PageProvider = PageProvider;