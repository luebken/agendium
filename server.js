//require the actual express app
app = require ("./lib/app").app

var port = parseInt(process.env.PORT || 8000);
//app.listen(port, null);
console.log('Server not listening on ' + port);
