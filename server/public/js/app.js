var jQT = new $.jQTouch({
    icon: 'jqtouch.png',
    addGlossToIcon: false,
    startupScreen: 'jqt_startup.png',
    statusBar: 'black'
});

var app = {

/*	
	createPage:function(page) {
		var $page = $('<div id="' + page.title + '">');
		$page.append('<div class="toolbar"><a class="back">Back</a><h1>'+ page.title+'</h1></div>');
		$page.insertAfter($("#otherpages"));
		return $page;		
	}

*/
}

$(function(){
    console.log('myfunction(data): ' + data.rootpage.children[0].title);
});