PageMaker = function(){
};

PageMaker.prototype.pages = function(data) {
    return this.createAndInsertPage(data.rootpage, "r", data.rootpage.title)
}

PageMaker.prototype.createAndInsertPage = function(page, pageid, appname) {   
 	if(page.type === 'Navigation') {
      return this.createList(page, pageid, appname);
    }
    if(page.type === 'Detail') {
        return this.createDetails(page, pageid, appname);
    }    
    return "";	
}

PageMaker.prototype.createList = function(page, pageid, appname) {
    var pagehtml = '<div data-role="page" id="' + pageid + '">';
    pagehtml += '<div data-role="header"><h1>' + page.title + '</h1></div>';
    var childhtml = '';
    var content = '<div data-role="content">';
    if(page.subtitle) content += '<h3>' + page.subtitle + '</h3>';
    var ulstart = '<ul data-role="listview" data-theme="a" data-dividertheme="b" data-inset="true">';
    content += ulstart;
    for(var i=0; i < page.children.length; i++) {
        var childpageid = pageid + 'c' + i;
        var child = page.children[i];
        if(child.type === 'Spacer'){
            content += '</li></ul>' + ulstart;
            if(child.title) content += '<li data-role="list-divider">' + child.title + '</li>';                
        } else {
            content += '<li><a href=#'+ childpageid +'>'  + child.title;
            content += '<br/><small>'+child.subtitle+'</small>';
            content += '</a></li>';
        }
        childhtml += this.createAndInsertPage(child, childpageid, appname);
    }
    content += '</ul></div>';
    pagehtml += content;
    pagehtml += '</div>';
    
    return pagehtml + childhtml;
}

PageMaker.prototype.createDetails = function(page, pageid, appname) {
    var pagehtml = '<div data-role="page" id="' + pageid + '">';
    pagehtml += '<div data-role="header"><h1>' + page.title + '</h1></div>';
    pagehtml += '<div data-role="content">';
    pagehtml += '<button pageid="' + pageid + '" appname="' + appname + '">Star</button>';
	pagehtml += '<h3>' + page.title + '</h3>';
    pagehtml += '<h4>' + page.subtitle + '</h4>';
    for(var i=0; i < page.attributes.length; i++) {
        var attr = page.attributes[i];
        if(attr.value.match("^http\://")){
            pagehtml += '<div class="attribute"><span class="key">' + attr.key + '</span>: <a href="' + attr.value + '">'+attr.value+'</a></div>';        
        } else {
            pagehtml += '<div class="attribute"><span class="key">' + attr.key + '</span>: ' + attr.value + '</div>';                    
        }
    }
    pagehtml += '</div>'; //content
    pagehtml += '</div>'; //page
    return pagehtml;
}


exports.PageMaker = PageMaker;