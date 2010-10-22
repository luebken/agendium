var toggleFavouriteSession = function($button) {
    var $origLink = $($button.parent().children()[1]); //hidden by jqmobile
    var pageid = $origLink.attr('pageid');
	var $link = $('li a[href=#' + pageid + ']').parent().parent().parent();
    var storageid = $origLink.attr('appname') + ":" + pageid;
    if (!localStorage.getItem(storageid)) {
		localStorage.setItem(storageid, "somevalue");
		//$el.removeAttr('data-icon');
        //$el.attr('data-icon', 'staron');
        $button.text('Unstar');
		$link.removeClass('staroff');
        $link.addClass('staron');
    } else {
		localStorage.removeItem(storageid);	
		//$el.removeAttr('data-icon');
        //$el.attr('data-icon', 'star');
        $button.text('Star'); 
		$link.removeClass('staron');
        $link.addClass('staroff');
    }
}
var setStars = function() {
    $.each($('li[role=option] a'), function(idx, value) {
        var link = $(value);
        var pageid = link.attr('href');
        pageid = pageid.substring(1, pageid.length);
        var storageid =  data.rootpage.title + ":" +pageid;
        if(localStorage.getItem(storageid)) {
            link.parent().parent().parent().addClass('staron');
        }        
    });
    
}


$(function(){
    $('button').bind('click', function(){
        toggleFavouriteSession($(this));        
    });
    setStars();
});