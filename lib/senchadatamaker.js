SenchaDataMaker = function(){
};


SenchaDataMaker.prototype.make = function(data) {
    return this.navitem(data.rootpage)
}

SenchaDataMaker.prototype.navitem = function(page) {
    var result = {};
    result.text = page.title;
    if(page.subtitle) result.text = result.text + " | " + page.subtitle;
    result.items = [];
    if(page.type == 'Navigation') {
        for(var i=0; i < page.children.length; i++) {
            result.items[i] = this.navitem(page.children[i]);
        }
    } else {
        result.items[0] = this.detailitem(page.subtitle);
        for(var i=0; i < page.attributes.length; i++) {
            result.items[i+1] = this.detailitem(page.attributes[i].key + " : " + page.attributes[i].value);
        }
    }
    return result;
}

SenchaDataMaker.prototype.detailitem = function(text) {
    var result = {};
    result.text = text;
    result.leaf = true;
    return result;
}


exports.SenchaDataMaker = SenchaDataMaker;