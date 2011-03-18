require.paths.unshift('vendor/testlib');
require.paths.unshift('lib');

var vows = require('vows'),
    assert = require('assert');   

var http = require('http'),
    app = require('app').app,
    agendaProvider = require('app').agendaProvider,
    userProvider = require('app').userProvider;
     
var client;
var app;

//helper
function assertStatus(code) {
    return function (res, y) {
        assert.equal (res.statusCode, code);
    };
}
var api = {
    get: function (path) {
        return function () {
            var request = client.request('GET', path, {'host': 'localhost:8000'});
            request.end();
            request.on('response', this.callback);
        };
    },
    post: function (path, body, optionalCallback) {
        return function () {            
            var options = {
              host: 'localhost',
              port: 8000,
              path: path,
              method: 'POST',
              headers: {'Content-length': body.length, 'Content-type': 'application/json'}
            };
            var req = http.request(options, optionalCallback || this.callback);
            req.write(body);
            req.end();
        };
    }
};

// Create a Test Suite
vows.describe('app')
.addBatch({
    'app is configured': {
        topic: function () {
            app.listen(8000);            
            client = http.createClient(8000, 'localhost');
            return null;
        },
        'app is not null': function (topic) {
            assert.isNotNull(app);
            assert.isNotNull(userProvider);
            assert.isNotNull(agendaProvider);
        }
    }
    
})


.addBatch({
    'app serves root file': {
        topic: api.get('/'),
        'should respond with a 200': assertStatus(200)
    },
    'app serves index file': {
        topic: api.get('/index.html'),
        'should respond with a 200': assertStatus(200)
    },
    'app doesnt serve unknown files': {
        topic: api.get('/asdasda'),
        'should respond with a 404': assertStatus(404)
    },
    'app doesnt serve unknown agenda ': {
        topic: api.get('/agenda/unknownagenda'),
        'should respond with a 404': assertStatus(404)
    }
})

.addBatch({
    'app should accept a post to /agenda': {        
        topic: api.post('/agenda', '{"holle":"holla"}'),
        'should respond with a 200': assertStatus(200)
    },
    'app shouldnt accept a post to /blabla': {        
        topic: api.post('/blabla', '{"holle":"holla"}'),
        'should respond with a 404': assertStatus(404)
    },
    'app shouldnt accept a broken json': {        
        topic: api.post('/blabla', '{XholleX:LhollaL}'),
        'should respond with a 400': assertStatus(500) //should actually be 400 
    }
})

.addBatch({
    'app shouldnt accept a with missing user post to /password': {        
        topic: api.post('/password', '{"holle":"holla"}'),
        'should respond with a 404': assertStatus(404)
    },
    'app shouldnt accept a post with missing password to /password': {        
        topic: api.post('/password', '{"user":"testuser"}'),
        'should respond with a 404': assertStatus(404)
    },
    'app shouldnt accept a post with missing newpassword to /password': {        
        topic: api.post('/password', '{"user":"testuser", "oldpassword":"testuser"}'),
        'should respond with a 404': assertStatus(404)
    },
    'app shouldnt accept a wellformed post to /password': {        
        topic: api.post('/password', '{"user":"testuser", "oldpassword":"testpassold", "newpassword":"testpassnew" }'),
        'should respond with a 200': assertStatus(200)
    }
})


.addBatch({
    'app shouldnt accept a with missing email post to /user': {        
        topic: api.post('/user', '{"holle":"holla"}'),
        'should respond with a 404': assertStatus(404)
    },
    'app shouldnt accept a with missing password post to /user': {        
        topic: api.post('/user', '{"email":"holla"}'),
        'should respond with a 404': assertStatus(404)
    },
    'app shouldnt accept a with missing shownintro post to /user': {        
        topic: api.post('/user', '{"email":"holla", "hashedpassword":"123123123"}'),
        'should respond with a 404': assertStatus(404)
    }
    ,
    'app should accept a post to /user': {        
        topic: function(){
            var user = {'email': 'testuser', 'password':'testpassword', 'shownintro': 'false' };
            userProvider.save(user, function(err, inserted) {
                console.log(api.post('/user', JSON.stringify(user), this.callback)());                
            }.bind(this));
        }, 
        'should respond with a 200': assertStatus(200)
    }
    
    
})

.addBatch({
    'app is closed': {
        topic: function() {
            agendaProvider.close();
            userProvider.close();
            
            app.close();
            app = null;
            return null;
        },
        'app is null': function (topic) {
            assert.isNull(app);
        }
    }
})
.export(module)