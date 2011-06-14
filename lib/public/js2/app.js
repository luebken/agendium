var toggleFavouriteSession = function($button) {
    var pageid = $button.attr('pageid');
	var $link = $('li a[href=#' + pageid + ']').parent().parent().parent();
    var storageid = $button.attr('appname') + ":" + pageid;
    var $page = $('#'+pageid+' [data-role="content"]');
    if (!localStorage.getItem(storageid)) {
        console.log('staron');
		localStorage.setItem(storageid, "somevalue");
        $link.addClass('staron');
        $page.addClass('staron');
    } else {
		console.log('staroff');
		localStorage.removeItem(storageid);	
		$link.removeClass('staron');
		$page.removeClass('staron');   
    }
}
var setStars = function() {
    $.each($('li[role=option] a'), function(idx, value) {
        var link = $(value);
        var pageid = link.attr('href');
        pageid = pageid.substring(1, pageid.length);
        var storageid =  data.rootpage.title + ":" + pageid;
        if(localStorage.getItem(storageid)) {
            //navigation link
            link.parent().parent().parent().addClass('staron');
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
});