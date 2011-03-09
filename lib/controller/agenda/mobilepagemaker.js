MobilePageMaker = function(){
};

MobilePageMaker.prototype.pages = function(data) {
    return this.createAndInsertPage(data.rootpage, "r", data.rootpage.title)
}

MobilePageMaker.prototype.createAndInsertPage = function(page, pageid, appname) {   
    if(page.type === 'Navigation') {
        return this.createList(page, pageid, appname);
    }
    if(page.type === 'Detail') {
        return this.createDetails(page, pageid, appname);
    }    
    return "";	
}

MobilePageMaker.prototype.createList = function(page, pageid, appname) {
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
        if(child.type === 'Group'){
            content += '</li></ul>' + ulstart;
            if(child.title) content += '<li data-role="list-divider">' + child.title + '</li>';                
        } else {
            var workaround = "";
            var lastChild = page.children.length === i+1;
            var oneInAGroup = lastChild || page.children[i+1].type === 'Group';
            if(lastChild || oneInAGroup) workaround = "class='ui-corner-bottom'";   

            content += '<li '+ workaround + '><a href=#'+ childpageid +'>'  + child.title;
            if(child.subtitle) content += '<br/><small>' + child.subtitle + '</small>';
            content += '</a></li>';
        }
        childhtml += this.createAndInsertPage(child, childpageid, appname);
    }
    content += '</ul></div>';
    pagehtml += content;
    pagehtml += '</div>';

    return pagehtml + childhtml;
}

MobilePageMaker.prototype.createDetails = function(page, pageid, appname) {
    var pagehtml = '<div data-role="page" id="' + pageid + '">';
    pagehtml += '<div data-role="header"><h1>' + page.title + '</h1></div>';
    pagehtml += '<div data-role="content">';
    pagehtml += '<button pageid="' + pageid + '" appname="' + appname + '">Star</button>';
    pagehtml += '<h3>' + page.title + '</h3>';
    if(page.subtitle) pagehtml += '<h4>' + page.subtitle + '</h4>';
    for(var i=0; i < page.attributes.length; i++) {
        var attr = page.attributes[i];
        if(attr.value.match("^http\://")){
            pagehtml += '<div class="attribute link"><span class="key">' + attr.key + '</span>: <a href="' + attr.value + '">'+attr.value+'</a></div>';        
        } else {
            pagehtml += '<div class="attribute"><span class="key">' + attr.key + '</span>: ' + attr.value + '</div>';                    
        }
    }
    pagehtml += '</div>'; //content
    pagehtml += '</div>'; //page
    return pagehtml;
}


exports.MobilePageMaker = MobilePageMaker;