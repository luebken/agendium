var AgendaProvider = require('./agendaprovider').AgendaProvider;
var agendaProvider = new AgendaProvider();

var MobilePageMaker = require('./mobilepagemaker').MobilePageMaker;
var pagemaker = new MobilePageMaker();

exports.register = function(app) {
    // === agenda crud  ===
    app.get('/agenda/:userid/:name', function(req, res){
        agendaProvider.findByUseridAndName(req.params.userid, req.params.name, function(error, data){
            if(data != null) {
                res.send(JSON.stringify(data), { 'Content-Type': 'application/json' }, 200);            
            } else {
                res.send(null, 404);                        
            }
        })
    })
    app.get('/isnameok/:name/:id', function(req, res){
        agendaProvider.isNameOK(req.params.name, req.params.id, function(error, data){
            if(data != null) {
                res.send(JSON.stringify(data), { 'Content-Type': 'application/json' }, 200);            
            } else {
                res.send(null, 404);                        
            }
        })
    })
    app.post('/agenda', function(req, res){
        try {
            var data = JSON.parse(req.rawBody);           
            agendaProvider.save(data, function(error, data2) {
                var json = JSON.stringify(data2); //hexes the id
                res.send(json, 200);     
            });
        } catch(exc) {
            console.log('exception during post ' + exc);
            res.send("", 404);
        }
    });

    // === mobile client  ===
    //Serves the mobile jquery mobile client
    app.get('/m/manifest-:name.mf', function(req, res){ 
        agendaProvider.findByName(req.params.name, function(error, data){
            if(data != null) {
                var mf = 'CACHE MANIFEST\n'; 
                if((data.offline == '0')) { //old request
                    mf += new Date(); //adding some data to trigger reload
                } else {
                    mf += '/js2/jquery-1.6.1.min.js\n';
                    mf += '/js2/jquery.mobile-1.0b1.min.js\n';
                    mf += '/js2/bookmark_bubble.js\n';
                    mf += '/js2/app.js\n';
                    mf += '/data/'+ req.params.name + '\n';
                    mf += '/js2/app.css\n';
                    mf += '/js2/jquery.mobile-1.0b1.min.css\n';
                    mf += '/js2/images/icons-18-white.png\n';
                    mf += '/js2/images/ajax-loader.png\n';
                }
                res.send(mf, { 'Content-Type': 'text/cache-manifest' }, 200);                        
            } else {
                res.send(null, 404);                        
            }
        })
    })
    
    //Serves the mobile jquery mobile client
    app.get('/m/:name', function(req, res){   
        agendaProvider.findByName(req.params.name, function(error, data){
            if(data != null) {
                var manifest = data.offline == 1 ? 'manifest-' + data.rootpage.title + '.mf' : '';
                res.render('mobileagenda.jade', {
                    layout: false,
                    rootpage: data.rootpage,
                    manifest: manifest,
                    pages: pagemaker.pages(data)
                })
            } else {
                res.send(null, 404);                        
            }
        })
    })


    //Serves the mobile client preview. 
    //Not by name because it might have been changed. 
    app.get('/prev/:id', function(req, res){   
        agendaProvider.findById(req.params.id, function(error, data){
            if(data != null) {
                res.render('mobileagenda.jade', {
                    layout: false,
                    rootpage: data.rootpage,
                    manifest: "",
                    pages: pagemaker.pages(data)
                })
            } else {
                res.send(null, 404);                        
            }
        })

    })

    //Serves the empty preview
    app.get('/preview', function(req, res){
        res.render('emptypreview.jade', {
            layout: false
        })
    })

    //Serves the agenda data as JSON for the mobile client 
    //FIXME why not use get('/agenda/*' just because auf "var data"
    app.get('/data/:name', function(req, res){
        agendaProvider.findByName(req.params.name, function(error, data){
            if(data != null) {
                res.send('var data = ' + JSON.stringify(data), { 'Content-Type': 'application/json' }, 200);            
            } else {
                res.send(null, 404);                        
            }
        })
    })
}
//Export for Tests
exports.agendaProvider = agendaProvider;