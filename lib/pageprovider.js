require.paths.unshift("./vendor/lib");

var Db = require('mongodb').Db;
var mongoconnect = require('mongodb').connect;
var ObjectID = require('mongodb/bson/bson').ObjectID;
var Server = require('mongodb/connection').Server;
var url = require('url');

PageProvider = function(){
    this.db = null;
};

PageProvider.prototype.connect = function(callback) {
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
PageProvider.prototype.close = function() {
    this.db.close();
    this.db = null;
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

PageProvider.prototype.save = function(data, callback) {
    this.getCollection(function(error, page_collection) {
      if( error ) callback(error)
      else {
        if(!data.userid) {
            callback( new Error())
        }
        if(data._id === 'undefined') {
            data._id = null; //WORKAROUND WHY???   
        } else {
            data._id = ObjectID.createFromHexString(data._id);
        }
        page_collection.save(data, function(error, inserted_data) {            
            callback(error, inserted_data);
        });
               
      }
    });
};

PageProvider.prototype.removeAll = function(callback) {
    this.getCollection(function(error, page_collection) {
      if( page_collection ) page_collection.remove();
      callback();
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

//callback(true) => name not found | id = name.id
PageProvider.prototype.isNameOK = function(name, id, callback) {
    this.findByName(name, function(error, result) {
        if( error ) callback(error);
        else {
            if(result) {
                callback(null, id === result._id.toHexString());
            } else {
                callback(null, true);
            }
        }
    });
}

//returns the page without the user id
PageProvider.prototype.findByName = function(name, callback) {
    this.getCollection(function(error, pages_collection) {
      if( error ) callback(error);
      else {
        //not case sensitive
        pages_collection.findOne({"rootpage.title": new RegExp(name, "i") }, function(error, result) {
          if( error ) callback(error)
          else {
              if(result) result.userid = null;  
              callback(null, result);
          }
        });
      }
    });
};

//the user id has to match
PageProvider.prototype.findByUseridAndName = function(userid, name, callback) {
    this.getCollection(function(error, pages_collection) {
      if( error ) callback(error);
      else {
        //not case sensitive
        pages_collection.findOne({"rootpage.title": new RegExp(name, "i") }, function(error, result) {
          if( error ) callback(error)
          else callback(null, result)
        });
      }
    });
};



exports.PageProvider = PageProvider;