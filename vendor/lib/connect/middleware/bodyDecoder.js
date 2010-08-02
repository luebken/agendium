
/*!
 * Ext JS Connect
 * Copyright(c) 2010 Sencha Inc.
 * MIT Licensed
 */

/**
 * Module dependencies.
 */

var queryString = require('querystring');

/**
 * Extract the mime type from the given request's
 * _Content-Type_ header.
 *
 * @param  {IncomingMessage} req
 * @return {String}
 * @api private
 */

function mime(req) {
    var str = req.headers['content-type'] || '';
    return str.split(';')[0];
}

/**
 * Supported decoders.
 *
 *  - application/x-www-form-urlencoded
 *  - application/json
 */

exports.decode = {
    'application/x-www-form-urlencoded': queryString.parse,
    //'application/xml': JSON.parse, //PATCH: Add this to get auto decoding for your application type
    'application/json': JSON.parse
};

/**
 * Decode request bodies.
 *
 * @return {Function}
 * @api public
 */

module.exports = function bodyDecoder(){
    return function bodyDecoder(req, res, next) {
        var decoder = exports.decode[mime(req)];
        if (decoder) {
            var data = '';
            req.setEncoding('utf8');
            req.addListener('data', function(chunk) { data += chunk; });
            req.addListener('end', function() {
                req.rawBody = data;
                try {
                    req.body = data
                        ? decoder(data)
                        : {};
                } catch (err) {
                    return next(err);
                }
                next();
            });
        } else {
            //PATCH: start
            var data = '';
            req.addListener('data', function(chunk) { data += chunk; });
            req.addListener('end', function() {
              req.rawBody = data; 
              next();
            });
            //PATCH: end
            //next(); //uncomment to unpatch
        }
    }
};