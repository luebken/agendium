require.paths.unshift("./lib");
require.paths.unshift("./vendor/lib");

var express = require('express'),
    connect = require('connect');       
var userroutes = require('controller/user/userroutes'),
    agendaroutes = require('controller/agenda/agendaroutes')
     
/**
 * Setup
 */
var pub = __dirname + '/public';
var app = express.createServer();
app.configure(function(){ 
    app.use(connect.bodyParser()); 
    app.use(connect.methodOverride()); 
    app.use(connect.static(pub));
});
app.set('views', __dirname + '/views')
app.set('view engine', 'jade');


/**
 * Register routes
 */
userroutes.register(app);
agendaroutes.register(app);

/**
 * Export for Tests
 */
exports.app = app;
exports.agendaProvider = agendaroutes.agendaProvider;
exports.userProvider = userroutes.userProvider;

