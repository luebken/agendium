require.paths.unshift('vendor/testlib');

var vows = require('vows'),
    assert = require('assert');   

var http = require('http'),
     app = require('../lib/app').app;
     
app.listen(8000);
var client = http.createClient(8000, 'localhost');

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
    }
};

// Create a Test Suite
vows.describe('app')
.addBatch({
    'app is configured': {
        topic: null,
        'app is not null': function (topic) {
            assert.isNotNull (app);
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
.run();