var createAndInsertPage = function(page, pageid, appname) {
 	var $page = $('<div class="ui-page ui-body-c" data-role="page" id="' + pageid + '">');
 	$page.append('<div data-role="header"><h1>' + page.title + '</h1></div>');
 	if(page.type === 'Navigation') {
       $page.append(createList(page, pageid, appname));
    }
    if(page.type === 'Detail') {
        $page.append(createDetails(page, pageid, appname));
    }
    $("body").prepend($page);	
}


var createList = function(page, pageid, appname) {
    var ulstart = '<ul data-role="listview" data-theme="a" data-dividertheme="b" data-inset="true">';
    var ul = '<div data-role="content">' + ulstart;
    //if(page.subtitle) ul += '<h2>'+page.subtitle+'</h2>';
    for(var i=0; i < page.children.length; i++) {
        var childpageid = pageid + 'c' + i;
        var child = page.children[i];
        if(child.type !== 'Spacer'){
            ul += '<li><a href=#'+ childpageid +'>'  + child.title + '</a></li>';
        } else {
            ul += '</ul>' + ulstart + '<li data-role="list-divider">' + child.title + '</li>';
        }
        createAndInsertPage(child, childpageid, appname);
    }
    return ul + '</ul></div>';
}

var createDetails = function(page, pageid, appname) {
    var $details = $('<div data-role="content">');
    $details.append('<h1>' + page.title + '</h1>');
    //var clazz = localStorage.getItem(appname+":"+pageid) ? "staron" : "staroff";
    //var star = '<a href="#" class=' + clazz + ' pageid="' + pageid + '" appname="' + appname + '">&nbsp;</a>';
	//$details.append(star);
    $details.append('<h2>' + page.subtitle + '</h2>');
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


var load = function() {
    var application = data.rootpage.title;
    createAndInsertPage(data.rootpage, "r", application);
}

$(function(){
    load();
    //$('#r').addClass('ui-page-active');
    
//    $.changePage('r', 'r', 'none', false);
});