sys = require('sys')

var pageCounter = 1;

PageProvider = function(){};
PageProvider.prototype.dummyData = [];

PageProvider.prototype.findAll = function(callback) {
  callback( null, this.dummyData )
};

PageProvider.prototype.findByName = function(name, callback) {
  sys.print('findByName:' + name + '\n')
  var result = null;
  for(var i =0;i<this.dummyData.length;i++) {
    if( this.dummyData[i].rootPage.title == name ) {
      result = this.dummyData[i];
      break;
    }
  }
  callback(null, result);
};

PageProvider.prototype.save = function(pages, callback) {
  var page = null;

  if( typeof(pages.length)=="undefined")
    pages = [pages];

  for( var i =0;i< pages.length;i++ ) {
    page = pages[i];
    //page._id = pageCounter++;
    //article.created_at = new Date();
    this.dummyData[this.dummyData.length] = page;
  }
  callback(null, pages);
};

/* Lets bootstrap with dummy data */
new PageProvider().save(
[
  { 
    id : '4711',
    rootPage: { 
        title: 'test',
        subtitle: 'A Test Agenda',
        children : [{
            title: 'Day 1',
            subtitle: 'Sessions on the first day',
            children : [{
                title: 'The first session',
                subtitle: '9:00-11:00',
                children : []
            },
            {
                title: 'The second session',
                subtitle: '12:00-13:00',
                children : []
            }
            ]
            }, 
            {
                title: 'Day 2',
                subtitle: 'Sessions on the second day',
                children : []
            }]
    }
  }
], function(error, pages){});

exports.PageProvider = PageProvider;
