require.paths.unshift("./vendor/lib");

var Db = require('mongodb').Db;
var mongoconnect = require('mongodb').connect;
var ObjectID = require('mongodb/bson/bson').ObjectID;
var Server = require('mongodb/connection').Server;
var url = require('url');

AgendaProvider = function(){
    this.db = null;
};

AgendaProvider.prototype.connect = function(callback) {
    var self = this;
    var url = process.env['MONGOHQ_URL'];
    if(!url) throw new Error('No MONGOHQ_URL defined!')
    if(self.db) {
        callback(self.db);
    } else {
        mongoconnect(url, function(err, db){
            self.db = db;
            callback(db);
        });        
    }
}
AgendaProvider.prototype.close = function() {
    if(this.db) this.db.close();
    this.db = null;
}

AgendaProvider.prototype.getCollection = function(callback) {
    this.connect(function(db) {
        db.collection('agenda', function(error, agenda_collection) {
            if(error) callback(error);   
            else callback(null, agenda_collection);
        });
    });
};

AgendaProvider.prototype.save = function(data, callback) {
    this.getCollection(function(error, agenda_collection) {
        if(error) callback(error);
        if(!data.userid) callback(new Error());     
        if(data._id === 'undefined') {//new
            data._id = null; //WORKAROUND WHY???   
        } else {
            //update
            data._id = ObjectID.createFromHexString(data._id);
        }
        agenda_collection.save(data, function(error, inserted_data) {            
            callback(error, inserted_data);
        });
    });
};

AgendaProvider.prototype.removeAll = function(callback) {
    this.getCollection(function(error, agenda_collection) {
        if(agenda_collection) agenda_collection.remove();
        callback();
    });
};


AgendaProvider.prototype.findById = function(id, callback) {
    this.getCollection(function(error, agenda_collection) {
        if(error) callback(error);
        else {
            agenda_collection.findOne({_id: ObjectID.createFromHexString(id)}, function(error, result) {
                if(error) callback(error);
                else callback(null, result);
            });
        }
    });
};

//callback(true) => name not found | id = name.id
AgendaProvider.prototype.isNameOK = function(name, id, callback) {
    this.findByName(name, function(error, result) {
        if(error) callback(error);
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
AgendaProvider.prototype.findByName = function(name, callback) {
    this.getCollection(function(error, agenda_collection) {
        if(error) callback(error);
        else {
            //not case sensitive
            agenda_collection.findOne({"rootpage.title": new RegExp(name, "i") }, function(error, result) {
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
AgendaProvider.prototype.findByUseridAndName = function(userid, name, callback) {
    this.getCollection(function(error, agenda_collection) {
        if(error) callback(error);
        else {
            //not case sensitive
            agenda_collection.findOne({"rootpage.title": new RegExp(name, "i") }, function(error, result) {
                if( error ) callback(error)
                else callback(null, result)
            });
        }
    });
};

exports.AgendaProvider = AgendaProvider;