sys = require('sys')

var idCounter = 0;

UserProvider = function(){};
UserProvider.prototype.dummyData = [
    {'email':'mdl', 'pass':''}, {'email':'test', 'pass':''}
];

UserProvider.prototype.checkUser = function(email, callback) {
  var result = false;
  for(var i=0; i<this.dummyData.length; i++) {
    if(this.dummyData[i].email == email ) {
      result = true;
      break;
    }
  }
  callback(null, result);
};


exports.UserProvider = UserProvider;