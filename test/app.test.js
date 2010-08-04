var http = require('http'),
 app = require('../lib/app').app;
 
module.exports = {
     'test setup': function(assert, beforeExit){
         assert.isNotNull(app);
     },    
     'test get static files': function(assert, beforeExit){
        assert.response(app, {
            url: '/',
            method: 'GET'
        },{
            status: 200,
            headers: {
                'Content-Type': 'text/html; charset=utf-8'
            }
        });
        assert.response(app, {
            url: '/someresourcethatdoesntexist',
            method: 'GET'
        },{
            status: 404
        });
        assert.response(app, {url: '/css/home.css'},{ status: 200 });
        assert.response(app, {url: '/favicon.ico'},{ status: 200 });
        assert.response(app, {url: '/images/bg.jpg'},{ status: 200 });
        assert.response(app, {url: '/js/app.css'},{ status: 200 });
        assert.response(app, {url: '/js/app.js'},{ status: 200 });
        assert.response(app, {url: '/Project/index.html'},{ status: 200 });
        assert.response(app, {url: '/Project/Frameworks/Objective-J/Objective-J.js'},{ status: 200 });
    },
    'test get agenda by id': function(assert, beforeExit){
        assert.response(app, {
            url: '/agenda/0',
            method: 'GET'
        },{
            status: 200,
            headers: {
                'Content-Type': 'application/json'
            }
        });
        assert.response(app, {url: '/agenda/nonexistingid'},{ status: 404 });
    },
    'test get mobile by id': function(assert, beforeExit){
        assert.response(app, {
            url: '/a/0',
            method: 'GET'
        },{
            status: 200,
                headers: {
                        'Content-Type': 'text/html; charset=utf-8'
                }
        });
    },
    'test save a new agenda': function(assert, beforeExit){
        assert.response(app, {
            url: '/agenda',
            method: 'POST',
            body : '{"test":"test"}'
        },{
            status: 200,
            headers: {
                'Content-Type': 'text/html; charset=utf-8'
            },
            body : '{"test":"test","_id":"1"}'
        });
    },
    'test save an existing agenda': function(assert, beforeExit){
        assert.response(app, {
            url: '/agenda',
            method: 'POST',
            body : '{"test":"test","_id":"4711"}'
        },{
            status: 200,
            headers: {
                'Content-Type': 'text/html; charset=utf-8'
            },
            body : '{"test":"test","_id":"4711"}'
        });
    }
};



