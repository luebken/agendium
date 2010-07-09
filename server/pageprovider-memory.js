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
    this.dummyData[this.dummyData.length] = page;
  }
  callback(null, pages);
};

/* Lets bootstrap with dummy data */
new PageProvider().save([
  { title: 'Day 1', 
    subtitle: 'Sessions in day one', 
    pages: [ 
    {
        title: '9:00-10:10', 
        subtitle: 'The first session', 
        pages : []
    },
    {
        title: '11:00-12:10', 
        subtitle: 'The second session', 
        pages : []
    },
    {
        title: '13:00-15:10', 
        subtitle: 'The third session', 
        pages : []
    }]
  },
  { title: 'Day 2', 
    subtitle: 'Sessions in the second day', 
    pages: [ 
    {
        title: '9:00-10:10', 
        subtitle: 'The first session', 
        pages : []
    },
    {
        title: '11:00-12:10', 
        subtitle: 'The second session', 
        pages : []
    },
    {
        title: '13:00-15:10', 
        subtitle: 'The third session', 
        pages : []
    }]
  },
  { title: 'Day 3', 
    subtitle: 'Sessions in the third day', 
    pages: []
  } 
], function(error, pages){});

exports.PageProvider = PageProvider;
