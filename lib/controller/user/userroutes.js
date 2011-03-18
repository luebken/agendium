var UserProvider = require('./userprovider').UserProvider;
var userProvider = new UserProvider();

//for development
userProvider.checkUser('mdl', 'mdl',  function(err, user) {
    if(user == undefined){
        userProvider.save({'email':'mdl', 'password':'mdl', 'shownintro':false});
    }
});

exports.register = function(app) {
    app.get('/user/:email/:password', function(req, res){
        userProvider.checkUser(req.params.email, req.params.password, function(err, data){
            var result = "undefined";
            if(data) {
                result = JSON.stringify(data);
            }
            res.send(result, { 'Content-Type': 'application/json' }, 200);            
        })
    });
    app.post('/password', function(req, res){
        try {
            var data = JSON.parse(req.rawBody);   
            var oldpassword = data.oldpassword;       
            var newpassword = data.newpassword;       
            var username = data.user; 
            if(!username || !oldpassword || !newpassword) {                
                console.log('incorrect data suring password post');
                console.log(data);
                res.send("", 404);
                return;
            }      
            userProvider.updatePassword(username, oldpassword, newpassword, function(err, data){
                res.send({ 'changed': JSON.stringify(true) }, { 'Content-Type': 'application/json' }, 200);            
            });
        } catch(exc) {
            console.log('exception during post ' + exc);
            res.send("", 404);
        }
    });
    
    app.post('/user', function(req, res){
        console.log('receiving post to /user')
        try {
            var data = JSON.parse(req.rawBody);   
            var email = data.email;       
            var hashedpassword = data.hashedpassword;       
            var shownintro = data.shownintro; 
            if(!email || !hashedpassword || !shownintro) {                
                console.log('incorrect data suring user post');
                console.log(data);
                res.send("", 404);
                return;
            }
            userProvider.updateShownIntro(email, hashedpassword, shownintro, function(err, data){
                if(err) {                    
                    res.send("", 404);
                    return;
                }
                res.send({ 'changed': JSON.stringify(true) }, { 'Content-Type': 'application/json' }, 200);            
            });
        } catch(exc) {
            console.log('exception during post ' + exc);
            res.send("", 404);
        }
    });
    
    app.get('/admin/:adminpassword', function(req, res){
        if(req.params.adminpassword == 'sehrgeheim123') {
            userProvider.getCollection(function(err, users_collection) {
                users_collection.find({}, function(err, cursor) {
                    cursor.toArray(function(err, users) {
                        res.render('admin.jade', {
                            layout: false,
                            users: users
                        })
                    })
                });  
            });
        } else {
            res.send("Nope", 200);                     
        }
    })
    app.post('/admin/create_secret_user', function(req, res){
        userProvider.checkUser(req.body.email, req.body.password, function(err, user){
            var result = "undefined";
            if(user == undefined) {
                userProvider.save({'email':req.body.email, 'password':req.body.email}, function(err, saved_user) {
                    if(err) res.send("Couldn't create user", 200);
                    res.send("Created user " + saved_user.email, 200);                
                });

            } else {
                res.send("Couldn't create user ", 200);                     
            }
        })
    })
}

//Export for Tests
exports.userProvider = userProvider;