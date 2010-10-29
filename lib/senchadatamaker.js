SenchaDataMaker = function(){
};


SenchaDataMaker.prototype.make = function(data) {
    return this.navitem(data.rootpage)
}

SenchaDataMaker.prototype.navitem = function(page) {
    var result = {};
    result.title = page.title;
    result.subtitle = page.subtitle;
    if(page.subtitle) result.text = result.text + " | " + page.subtitle;
    result.items = [];
    if(page.type == 'Navigation') {
        for(var i=0; i < page.children.length; i++) {
            result.items[i] = this.navitem(page.children[i]);
        }
    } else if(page.type == 'Spacer'){
        result.leaf = true;
    } else { //Detail
        result.items[0] = this.detailitem(page.title, page.subtitle);
        for(var i=0; i < page.attributes.length; i++) {
            result.items[i+1] = this.detailitem(page.attributes[i].key, page.attributes[i].value);
        }
    }
    return result;
}

SenchaDataMaker.prototype.detailitem = function(title, subtitle) {
    var result = {};
    result.title = title;
    result.subtitle = subtitle;
    result.leaf = true;
    return result;
}


exports.SenchaDataMaker = SenchaDataMaker;