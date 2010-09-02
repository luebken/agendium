var http = require('http'),
 app = require('../lib/app').app,
 pageProvider = require('../lib/app').pageProvider;
 
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
    },    
    'test get agenda by id': function(assert, beforeExit){
        assert.response(app, {url: '/agenda/nonexistingid'},{ status: 404 });    
            
        pageProvider.save({'_id':'undefined',"test":"test"}, function(error, page) {
            assert.response(app, {url: '/agenda/' + page._id.toHexString()},{ status: 200 }); 
            pageProvider.removeAll();           
        });    
    },
    'test get mobile by id': function(assert, beforeExit){
        assert.response(app, {url: '/a/nonexistingid'},{ status: 404 });        
        var page = {'_id':'undefined','rootpage': {'title':'my title'}};
        pageProvider.save(page, function(error, page) {
            assert.response(app, {url: '/a/' + page._id.toHexString()},{ status: 200 }); 
            pageProvider.removeAll();                      
        });
        
    },
    'test check an existing user': function(assert, beforeExit){
        assert.response(app, {
            url: '/user/mdl',
            method: 'GET'
        },{
            status: 200,
            headers: {
                'Content-Type': 'application/json'
            },
            body : 'true'
        });
    },
    'test check an non-existing user': function(assert, beforeExit){
        assert.response(app, {
            url: '/user/mdl2',
            method: 'GET'
        },{
            status: 200,
            headers: {
                'Content-Type': 'application/json'
            },
            body : 'false'
        });
    }
    
};



