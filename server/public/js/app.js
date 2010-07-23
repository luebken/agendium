var jQT = new $.jQTouch({
    icon: 'jqtouch.png',
    addGlossToIcon: false,
    startupScreen: 'jqt_startup.png',
    statusBar: 'black'
});

var createAndInsertPage = function(page, pageid) {
 	var $page = $('<div id="' + pageid + '">');
 	$page.append('<div class="toolbar"><a class="back">Back</a><h1>' + page.title + '</h1></div>');
 	if(page.type === 'Navigation') {
        $page.append(createList(page, pageid));
    }
    if(page.type === 'Detail') {
        $page.append(createDetails(page, pageid));
    }
    $page.insertAfter($("#otherpages"));	
}

var createList = function(page, pageid) {
 	var $ul = $('<ul class="rounded">'); 
    for(var i=0; i < page.children.length; i++) {
        var childpageid = pageid + 'c' + i;
        var child = page.children[i];
        var li = '<li class="arrow"><a href=#'+ childpageid +'>'  + child.title + '</a>';
        if(child.subtitle) {
            li += '<div class="small">'+ child.subtitle+'</div>';
        }
        li += '</li>';
        $ul.append(li);
        createAndInsertPage(child, childpageid);
    }
    return $ul;
}
var createDetails = function(page, pageid) {
    var $details = $('<div class="details">');
    $details.append('<div class="title">' + page.title + '</div>');
    $details.append('<div class="subtitle">' + page.subtitle + '</div>');
    for(var key in page.attributes) {
        var value = page.attributes[key];
        if(value.match("^http\://")){
            $details.append('<div class="attribute">' + key + ': <a href="' + value + '">'+value+'</a></div>');        
        } else {
            $details.append('<div class="attribute">' + key + ': ' + value + '</div>');                    
        }
    }
    return $details;
}


$(function(){
    createAndInsertPage(data.rootpage, "r");
});