var toggleFavouriteSession = function($button) {
    var pageid = $button.attr('pageid');
	var $link = $('li a[href=#' + pageid + ']').parent().parent().parent();
    var storageid = $button.attr('appname') + ":" + pageid;
    var $page = $('#'+pageid+' [data-role="content"]');
    if (!localStorage.getItem(storageid)) {
		localStorage.setItem(storageid, "somevalue");
        $link.addClass('staron');
        $page.addClass('staron');
    } else {
		localStorage.removeItem(storageid);	
		$link.removeClass('staron');
		$page.removeClass('staron');   
    }
}
var setStars = function() {
    $.each($('button'), function(idx, value) {
        var pageid = $(value).attr('pageid');
        var storageid = data.rootpage.title + ":" + pageid;
        if(localStorage.getItem(storageid)) {
            //navigation link
            var link = $('li a[href=#' + pageid + ']').parent();
            //ugly workaround since jqm populates the pages differently depending if their shown     
            if($(link).get(0).tagName != "LI") {
                link = link.parent().parent();
            }   
            link.addClass('staron');
            //content page
            $('#'+pageid+' [data-role="content"]').addClass('staron');
        }        
    });
}

var removeEventsForPreview = function () {
    $('a').unbind();
    $('a').undelegate();
    $('a').die();
    $('a').bind('click', function(e){
        e.preventDefault();
    });
}


$(function(){
    $('button').bind('click', function(){
        toggleFavouriteSession($(this));        
    });
    setStars();
    
    //show the bookmark bubble   
    window.setTimeout(function() {
      google.bookmarkbubble.Bubble.prototype.REL_ICON_ = 'apple-touch-icon';
      var bubble = new google.bookmarkbubble.Bubble();
      bubble.hasHashParameter = function() { return false; };
      bubble.setHashParameter = function() {};
      bubble.showIfAllowed();
    }, 1000); 
});

$(document).bind("mobileinit", function(){
 $.mobile.useFastClick  = false;
});

var cacheStatusValues = [];
cacheStatusValues[0] = 'uncached';
cacheStatusValues[1] = 'idle';
cacheStatusValues[2] = 'checking';
cacheStatusValues[3] = 'downloading';
cacheStatusValues[4] = 'updateready';
cacheStatusValues[5] = 'obsolete';

var cache = window.applicationCache;
cache.addEventListener('cached', logEvent, false);
cache.addEventListener('checking', logEvent, false);
cache.addEventListener('downloading', logEvent, false);
cache.addEventListener('error', logEvent, false);
cache.addEventListener('noupdate', logEvent, false);
cache.addEventListener('obsolete', logEvent, false);
cache.addEventListener('progress', logEvent, false);
cache.addEventListener('updateready', logEvent, false);

function logEvent(e) {
    var online, status, type, message;
    online = (navigator.onLine) ? 'yes' : 'no';
    status = cacheStatusValues[cache.status];
    type = e.type;
    message = 'online: ' + online;
    message+= ', event: ' + type;
    message+= ', status: ' + status;
    if (type == 'error' && navigator.onLine) {
        message+= ' (prolly a syntax error in manifest)';
    }
    console.log(message);
}

window.applicationCache.addEventListener(
    'updateready',
    function(){
        window.applicationCache.swapCache();
        console.log('swap cache has been called');
    },
    false
);

setInterval(function(){cache.update()}, 10000);