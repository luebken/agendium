var createAndInsertPage = function(page, pageid, appname) {
 	var $page = $('<div class="ui-page ui-body-c" data-role="page" id="' + pageid + '">');
 	$page.append('<div data-role="header"><h1>' + page.title + '</h1></div>');    
 	if(page.type === 'Navigation') {
       $page.append(createList(page, pageid, appname));
    }
    if(page.type === 'Detail') {
        $page.append(createDetails(page, pageid, appname));
    }
    $page.page();//jqmobile page
    $("body").prepend($page);	
}


var createList = function(page, pageid, appname) {
    var ulstart = '<ul data-role="listview" data-theme="a" data-dividertheme="b" data-inset="true">';
    var ul = '<div data-role="content">';
    if(page.subtitle) ul += '<h3>'+page.subtitle+'</h3>';
    ul += ulstart;
    for(var i=0; i < page.children.length; i++) {
        var childpageid = pageid + 'c' + i;
        var child = page.children[i];
        if(child.type !== 'Spacer'){
            var clazz = "";
            var storageid = appname + ":" + childpageid;
            if (localStorage.getItem(storageid)) clazz = 'class="staron"';
            ul += '<li '+clazz+' ><a href=#'+ childpageid +'>'  + child.title;
            ul += '<br/><small>'+child.subtitle+'</small>';
            ul += '</a></li>';
        } else {
            ul += '</ul>' + ulstart + '<li data-role="list-divider">' + child.title + '</li>';
        }
        createAndInsertPage(child, childpageid, appname);
    }
    return ul + '</ul></div>';
}

var createDetails = function(page, pageid, appname) {
    var $details = $('<div data-role="content">');
    var clazz = localStorage.getItem(appname+":"+pageid) ? "staron" : "staroff";
    var star = '<button pageid="' + pageid + '" appname="' + appname + '">Star</button>';
	$details.append(star);
	$details.append('<h3>' + page.title + '</h3>');
    
    $details.append('<h4>' + page.subtitle + '</h4>');
    for(var i=0; i < page.attributes.length; i++) {
        var attr = page.attributes[i];
        if(attr.value.match("^http\://")){
            $details.append('<div class="attribute">' + attr.key + ': <a href="' + attr.value + '">'+attr.value+'</a></div>');        
        } else {
            $details.append('<div class="attribute">' + attr.key + ': ' + attr.value + '</div>');                    
        }
    }
    return $details;
}

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
    //TODO Refresh on th button
    
}

var load = function() {
    var application = data.rootpage.title;
    createAndInsertPage(data.rootpage, "r", application);
}



$(function(){
    load();
    $('button').bind('click', function(){
        toggleFavouriteSession($(this));        
    });
    //goto rootpage
    //$('#r [data-role=header] a').hide();
    //location.hash = 'r';
    //$(window).trigger( "hashchange", { manuallyTriggered: true } );
    //$.changePage($('#current'), $('#r'), 'none', false);	
});