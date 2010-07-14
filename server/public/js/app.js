var jQT = new $.jQTouch({
    icon: 'jqtouch.png',
    addGlossToIcon: false,
    startupScreen: 'jqt_startup.png',
    statusBar: 'black'
});

var createAndInsertPage = function(page, pageid) {
 	var $page = $('<div id="' + pageid + '">');
 	$page.append('<div class="toolbar"><a class="back">Back</a><h1>' + page.title + '</h1></div>');
 	var $ul = $('<ul class="rounded">'); 
    for(var i=0; i < page.children.length; i++) {
        var childpageid = pageid + 'c' + i;
        var child = page.children[i];
        $ul.append('<li class="arrow"><a href=#'+ childpageid +'>'  + child.title + '</a><div class="small">'+ child.subtitle+'</div></li>');
        createAndInsertPage(child, childpageid);
    }
    $page.append($ul);
    $page.insertAfter($("#otherpages"));	
}


$(function(){
    createAndInsertPage(data.rootpage, "r");
});