require.paths.unshift('vendor/testlib');

var vows = require('vows'),
    assert = require('assert');    

var http = require('http'),
     app = require('../lib/app').app,
     pageProvider = require('../lib/app').pageProvider;

// Create a Test Suite
vows.describe('app').addBatch({
    'app is configured': {
        topic: null,
        'app is not null': function (topic) {
            assert.isNotNull (app);
        }
    }
}).addBatch({
    'app serves static files': {
        topic: function () {
            app.listen(8000);
            var client = http.createClient(80, 'localhost');
            var request = client.request('GET', '/', {'host': 'localhost:8000'});
            request.end();
            request.on('response', this.callback);
        },
        'should respond with a 200 OK': function (res, y) {
           assert.equal (res.statusCode, 200);
        }
    },
    'app doesnt serve unknown files': {
        topic: function () {
            var client = http.createClient(80, 'localhost');
            var request = client.request('GET', '/sasd', {'host': 'localhost:8000'});
            request.end();
            request.on('response', this.callback);
        },
        'should respond with a 404': function (res, y) {
           assert.equal (res.statusCode, 404);
        }
    }
}).run(); // Run it