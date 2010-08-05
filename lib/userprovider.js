mongoose = require('mongoose/mongoose').Mongoose;

//
// Mongo Setup
//
mongoose.model('User', {
    properties: ['email', 'password']
});

var dburl;
if(process.env['MONGOHQ_URL'] !== 'undefined') {
    dburl = 'mongodb://localhost/agendium';          
} else {
    dburl = process.env['MONGOHQ_URL'] + '/agendium';              
}
console.log('Connecting to db ' + dburl);

db = mongoose.connect(dburl);              
var User = db.model('User');

//
// Dummydata
//
var u = new User();
u.email = 'mdl';
u.save(function(){ sys.puts('Saved!'); });

//
// Custom API
//
UserProvider = function(){};
UserProvider.prototype.checkUser = function(email2, callback) {
  User.find({ email: email2 }).all(function(array){
      callback(null, array.length > 0);
  });
};

exports.UserProvider = UserProvider;
