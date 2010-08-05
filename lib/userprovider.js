mongoose = require('mongoose/mongoose').Mongoose;


//
// Mongo Setup
//
mongoose.model('User', {
    properties: ['email', 'password']
});

var connectdb = function() {
    var dburl;
    if(process.env['MONGOHQ_URL'] === undefined) {
        dburl = 'mongodb://localhost/agendium';          
    } else {
        dburl = process.env['MONGOHQ_URL'];              
    }
    console.log('Connecting to db ' + dburl);
    var connection = mongoose.connect(dburl);
    connection.addListener('error',function(errObj,scope_of_error){
        console.log('error ' + errObj);
    });
    return connection;                  
}
var db = connectdb();
var User = db.model('User');
var u = new User();
u.email = 'mdl';
u.save(function(){ sys.puts('Saved!'); });
//
// Custom API
//
UserProvider = function(){};
UserProvider.prototype.checkUser = function(email2, callback) {
  var db = connectdb();
  User.find({ email: email2 }).all(function(array){
      callback(null, array.length > 0);
      //db.close();
  });
};

exports.UserProvider = UserProvider;
