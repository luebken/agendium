SenchaDataMaker = function(){
};


SenchaDataMaker.prototype.make = function(data) {
    var rootpage = this.insertGroupsFromSpacers(data.rootpage);
    return this.navitem(rootpage);
}


SenchaDataMaker.prototype.insertGroupsFromSpacers = function(data) {
    if(!data.children) return data;
    
    var group;
    var newChildren = [];
    for (var i=0; i < data.children.length; i++) {
        var child = data.children[i];
        if(child.type == 'Spacer') {
            group = child.title;  
        } else {
            child.group = group;
            newChildren.push(child);
        } 
    };    
    data.children = newChildren;
    
    for (var i=0; i < data.children.length; i++) {
        var child = data.children[i];
        child = this.insertGroupsFromSpacers(child)
    }
    
    return data;
}

SenchaDataMaker.prototype.navitem = function(page) {
    var result = {};
    result.title = page.title;
    result.subtitle = page.subtitle;
    result.group = page.group;
    if(page.subtitle) result.text = result.text + " | " + page.subtitle;
    result.items = [];
    if(page.type == 'Navigation') {
        for(var i=0; i < page.children.length; i++) {
            result.items[i] = this.navitem(page.children[i]);
        }
    } else if(page.type == 'Spacer'){
        result.leaf = true;
    } else { //Detail
        result.items[0] = this.attributeitem(page.title, page.subtitle);
        for(var i=0; i < page.attributes.length; i++) {
            result.items[i+1] = this.attributeitem(page.attributes[i].key + ":", page.attributes[i].value);
        }
        result.leaf = true;
    }
    return result;
}

SenchaDataMaker.prototype.attributeitem = function(title, subtitle) {
    var result = {};
    result.title = title;
    if(subtitle.match("^http\://")){
        result.subtitle = '<a href="' + subtitle + '">'+subtitle+'</a>';
    } else {
        result.subtitle = subtitle;
    }
    return result;
}


exports.SenchaDataMaker = SenchaDataMaker;