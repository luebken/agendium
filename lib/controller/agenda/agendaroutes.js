var AgendaProvider = require('./agendaprovider').AgendaProvider;
var agendaProvider = new AgendaProvider();

var PageMaker = require('./pagemaker').PageMaker;
var pagemaker = new PageMaker();

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
    app.get('/m/:name', function(req, res){   
        agendaProvider.findByName(req.params.name, function(error, data){
            if(data != null) {
                res.render('indexjqmobile.jade', {
                  layout: false,
                  rootpage: data.rootpage,
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
                res.render('indexjqmobile.jade', {
                  layout: false,
                  rootpage: data.rootpage,
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

exports.agendaProvider = agendaProvider;