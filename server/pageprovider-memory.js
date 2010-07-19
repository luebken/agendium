sys = require('sys')

var idCounter = 0;

PageProvider = function(){};
PageProvider.prototype.dummyData = [];

PageProvider.prototype.findAll = function(callback) {
  callback( null, this.dummyData )
};

PageProvider.prototype.findByName = function(name, callback) {
  sys.print('findByName:' + name + '\n')
  var result = null;
  for(var i=0;i<this.dummyData.length;i++) {
    if(this.dummyData[i].rootpage.title == name ) {
      result = this.dummyData[i];
      break;
    }
  }
  callback(null, result);
};

PageProvider.prototype.findIndexById = function(id) {
  var index = undefined;
  for(var i=0;i<this.dummyData.length;i++) {
    if( this.dummyData[i]._id == id ) {
        index = i;
        break;
    }
  }
  if(index + '' === 'undefined') {
      index = idCounter++
  }
  //sys.print('findIndexById:' + id + ' returning index:' +  index + '\n')
  return index;
};

PageProvider.prototype.save = function(data, callback) {
    var index = this.findIndexById(data._id);
    if(!data._id || data._id == 'null' || data._id == 'undefined') {
        data._id = "" + index;
    }
    this.dummyData[index] = data;
    
    sys.print('Saved! Now we have ' + this.dummyData.length + ' data sets.\n');
    callback(null, data);
};

/* Lets bootstrap with dummy data */
new PageProvider().save(
  { 
    _id : '0',
    rootpage: { 
        type: 'List',
        title: 'test',
        subtitle: 'A Test Agenda',
        attributes : {},
        children : [{
            type: 'List',
            title: 'Day 1',
            subtitle: 'Sessions on the first day',
            attributes : {},
            children : [{
                type: 'List',
                title: 'The first session',
                subtitle: '9:00-11:00',
                attributes : {},
                children : []
            },
            {
                type: 'List',
                title: 'The second session',
                subtitle: '12:00-13:00',
                attributes : {},
                children : []
            }
            ]
            }, 
            {
                type: 'List',
                title: 'Day 2',
                subtitle: 'Sessions on the second day',
                attributes : {},
                children : []
            }, 
            {
                type: 'Detail',
                title: 'Some title of the Detail page',
                subtitle: 'Some Subtitle',
                attributes : {'key1':'value1', 'key2':'value2'},
                children : []
            }]
    }
  }, function(error, pages){});

exports.PageProvider = PageProvider;
