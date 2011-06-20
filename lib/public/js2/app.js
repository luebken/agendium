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
    
    setTimeout(new google.bookmarkbubble.Bubble().showIfAllowed(), 2000);
});