var jQT = new $.jQTouch({
    icon: '../images/touchicon.png',
    addGlossToIcon: true,
    startupScreen: '../images/touchsplash.png',
    statusBar: 'black'
});

var createAndInsertPage = function(page, pageid, appname) {
 	var $page = $('<div id="' + pageid + '">');
 	$page.append('<div class="toolbar"><a class="back">Back</a><h1>' + page.title + '</h1></div>');
 	if(page.type === 'Navigation') {
        $page.append(createList(page, pageid, appname));
    }
    if(page.type === 'Detail') {
        $page.append(createDetails(page, pageid, appname));
    }
    $("body").prepend($page);	
}

var createList = function(page, pageid, appname) {
    var ul = '';
    if(page.subtitle) ul += '<h2>'+page.subtitle+'</h2>';
 	ul += '<ul class="rounded">'; 
    for(var i=0; i < page.children.length; i++) {
        var childpageid = pageid + 'c' + i;
        var child = page.children[i];
        if(child.type !== 'Spacer'){
            var clazz = localStorage.getItem(appname + ":" + childpageid) ? '"staron"' : '"staroff"';
            var li = '<li class='+clazz+'><div class="chevron">';
            li += '<a href=#'+ childpageid +'>'  + child.title;
            if(child.subtitle) {
                li += '<div class="sub">'+ child.subtitle+'</div>';
            }
            li += '</a></div></li>';
            ul += li;            
        } else {
            ul += '</ul><h2>'+child.title+'</h2><ul class="rounded">';
        }
        createAndInsertPage(child, childpageid, appname);
    }
    return ul + '</ul>';
}
var createDetails = function(page, pageid, appname) {
    var $details = $('<div class="details">');
    $details.append('<span class="title">' + page.title + '</span>');
    var clazz = localStorage.getItem(appname+":"+pageid) ? "staron" : "staroff";
    var star = '<a href="#" class=' + clazz + ' pageid="' + pageid + '" appname="' + appname + '">&nbsp;</a>';
	$details.append(star);
    $details.append('<div class="subtitle">' + page.subtitle + '</div>');
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

var adaptHomepage = function() {
    jQT.goTo("#r");
    $('#r .toolbar .back').remove();
    $('#r .toolbar').append('<a href="#about" class="button slideup">About</a>')
    $('#r').append('<div class="info"><p> Add this page to your home screen to view the custom icon, startup screen, and full screen mode.</p></div>');
}

var load = function() {
    var application = data.rootpage.title;
    createAndInsertPage(data.rootpage, "r", application);
    adaptHomepage();    
} 

var remove = function () {
    $("#[id^=r]").remove();
}

var toggleFavouriteSession = function($el) {
    var pageid = $el.attr('pageid');
    var storageid = $el.attr('appname') + ":" + pageid;
    
	var $link = $('li a[href=#' + pageid + ']').parent().parent();
    if (!localStorage.getItem(storageid)) {
		localStorage.setItem(storageid, "somevalue");
		$el.removeClass('staroff');
        $el.addClass('staron');
		$link.removeClass('staroff');
        $link.addClass('staron');
    } else {
		localStorage.removeItem(storageid);	
		$el.removeClass('staron');
        $el.addClass('staroff');
		$link.removeClass('staron');
        $link.addClass('staroff');
    }
}

$(function(){
    load();
    $('.details a').bind('click', function(){
        toggleFavouriteSession($(this));        
    });
});