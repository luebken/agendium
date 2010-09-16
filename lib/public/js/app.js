var jQT = new $.jQTouch({
    icon: 'jqtouch.png',
    addGlossToIcon: false,
    startupScreen: 'jqt_startup.png',
    statusBar: 'black'
});

var createAndInsertPage = function(page, pageid, parent_pageid) {
 	var $page = $('<div id="' + pageid + '">');
 	$page.append('<div class="toolbar"><a href="#'+parent_pageid+'">Back</a><h1>' + page.title + '</h1></div>');
 	if(page.type === 'Navigation') {
        $page.append(createList(page, pageid));
    }
    if(page.type === 'Detail') {
        $page.append(createDetails(page, pageid));
    }
    $("#jqt").prepend($page);	
}

var createList = function(page, pageid) {
    var ul = '';
    if(page.subtitle) ul += '<h2>'+page.subtitle+'</h2>';
 	ul += '<ul class="rounded">'; 
    for(var i=0; i < page.children.length; i++) {
        var childpageid = pageid + 'c' + i;
        var child = page.children[i];
        if(child.type !== 'Spacer'){
            var li = '<li class="arrow"><a href=#'+ childpageid +'>'  + child.title ;
            //if(child.subtitle) {
            //    li += '<div class="sub">'+ child.subtitle+'</div>';
            //}
            li += '</a>';//'</li>';
            ul += li;            
        } else {
            ul += '</ul><h2>'+child.title+'</h2><ul class="rounded">';
        }
        createAndInsertPage(child, childpageid, pageid);
    }
    return ul + '</ul>';
}
var createDetails = function(page, pageid) {
    var $details = $('<div class="details">');
    $details.append('<div class="title">' + page.title + '</div>');
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
    createAndInsertPage(data.rootpage, "r");
    //adaptHomepage();    
} 

var remove = function () {
    $("#[id^=r]").remove();
}

$(function(){
    //load();
});