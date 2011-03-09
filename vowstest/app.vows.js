require.paths.unshift('vendor/testlib');
require.paths.unshift('lib');

var vows = require('vows'),
    assert = require('assert');   

var http = require('http'),
    app = require('app').app,
    agendaProvider = require('app').agendaProvider;
     
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
    post: function (path, body) {
        return function () {
            var request = client.request('POST', path, {'Content-Length': '27'});
            if(body) request.write(body)
            else request.write('{"bodyll":"s", "_id":"123"}');
            request.end();
            request.on('response', this.callback);
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
    }
})

.addBatch({
    'app doesnt serve unknown agenda ': {
        topic: api.get('/agenda/unknownagenda'),
        'should respond with a 404': assertStatus(404)
    }
})

/*
FUCK
.addBatch({
    'app should accept a post to /agenda': {        
        topic: api.post('/agenda'),
        'should respond with a 200': assertStatus(200)
    },
    'app shouldnt accept a post to /bblala': {        
        topic: api.post('/bblala'),
        'should respond with a 404': assertStatus(404)
    },
    'app shouldnt accept a flawed json': {        
        topic: api.post('/agenda', '{"bodyll":"s", "_id":"""123"}'),
        'should respond with a 404': assertStatus(404)
    }
})
*/

.addBatch({
    'app is closed': {
        topic: function() {
            agendaProvider.close();
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