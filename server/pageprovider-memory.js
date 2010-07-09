sys = require('sys')

var pageCounter = 1;

PageProvider = function(){};
PageProvider.prototype.dummyData = [];

PageProvider.prototype.findAll = function(callback) {
  callback( null, this.dummyData )
};

PageProvider.prototype.save = function(pages, callback) {
  var page = null;

  if( typeof(pages.length)=="undefined")
    pages = [pages];

  for( var i =0;i< pages.length;i++ ) {
    page = pages[i];
    page._id = pageCounter++;
    //article.created_at = new Date();
    this.dummyData[this.dummyData.length]= page;
  }
  callback(null, pages);
};

/* Lets bootstrap with dummy data */
new PageProvider().save([
  {title: 'Day 1', subtitle: 'All Superb Sessions'},
], function(error, pages){});

exports.PageProvider = PageProvider;
