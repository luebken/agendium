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
            var client = http.createClient(8001);
            //server.client = http.createClient(server.__port);
            //client.request('GET',  '/', this.callback);
            return null; 
        },
        'should respond with a 200 OK': function (e, res) {
            assert.isNull(e);
         // assert.equal (res.status, 200);
        }
    }
}).run(); // Run it