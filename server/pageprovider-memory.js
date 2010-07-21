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
        title: 'FOWA2010',
        attributes : {},
        children : [{
            type: 'List',
            title: 'Conference Day 01',
            subtitle: '04 October, 2010',
            attributes : {},
            children : [{
                type: 'Detail',
                title: 'NOW is the time!',
                subtitle: 'Track 01: 09.00 - 09.40',
                attributes : {
                    Speaker: 'David Hauser',
                    Details: 'There has never been a better or more exciting time to be in the web industry. In this session David will fire you up and get you ready to go out and change the world with your apps and ideas.'
                },
                children : []
            },
            {
                type: 'Detail',
                title: 'Marketing your Web App',
                subtitle: 'Track 01: 09.45 - 10.25',
                attributes : {
                    Speaker: 'Mike McDerment',
                    Details: 'Your app is live, now it\'s time to let the world know about your service. Mike McDerment successfully launched FreshBooks in 2004 and has grown the company to 40+ people and millions in revenue. He\'ll share his proven tactics for marketing web apps and offer simple ways of measuring your campaign\'s success.'
                },
                children : []
            },
            {
                type: 'Detail',
                title: 'WebOS and Chrome OS',
                subtitle: 'Track 02: 09.45 - 10.25',
                attributes : {
                    Speaker: 'TBC',
                    Details: 'The days of building solely for the "web" are almost over. With the imminent release of Google\'s ChromeOS and the wider adoption on WebOS it\'s time to consider how our applications will work on these platforms. This session will take a look at the latest developments and will highlight the ways in which web developers can take advantage of the new technologies such as HTML5, offline storage, notifications and local data store.'
                },
                children : []
            },
            {
                type: 'Detail',
                title: '=== Morning Break ===',
                subtitle: '10.30 - 11.15',
                attributes : {
                    Details: 'A chance to meet up with your friends and have a cup of coffee on the house!'
                },
                children : []
            },
            {
                type: 'Detail',
                title: 'How to Write Stunning Applications with Less Code',
                subtitle: 'Track 01: 11.15 - 11.50',
                attributes : {
                    Speaker: 'Francisco Tolmasky',
                    Details: 'Development frameworks have been in vogue for a number of years but with the uptake of devices like the iPhone and iPad many developers have been turning their hand to coding applications for platforms other than the web. In this presentation Francisco Tolmasky (the creator of Cappuccino, an open source framework that makes it easy to build desktop-caliber applications that run in a web browser) will show you how to produce an application that can be deployed to multiple platforms with minimal code.'},
                children : []
            },
            {
                 type: 'Detail',
                 title: 'How to Get Great Media Coverage for your new Business',
                 subtitle: 'Track 02: 11.15 - 11.50',
                 attributes : {
                        Speaker: 'Shaa Wasmund',
                        Details: 'Getting media coverage has changed and in will be even more radically different in the future. In this talk you\'ll learn about the upcoming changes in media and how you can use them to get your site or app covered to increase traffic and conversions.'},
                    children : []
            },
            {
                 type: 'Detail',
                 title: 'Leveraging Social',
                 subtitle: 'Track 01: 11.55 - 12.35',
                 attributes : {
                        Speaker: 'Iain Dodsworth',
                        Details: 'Iain Dodsworth has grown TweetDeck to be the leading Twitter client. He\'s now taking it to the next level by integrating Google Buzz, Foursquare, Facebook and more. In this talk he\'s going to explain how you can use services and APIs from other web apps to augment your own and make your offering more powerful.'},
                    children : []
            },
            {
                 type: 'Detail',
                 title: 'Proven Email Marketing Tactics',
                 subtitle: 'Track 02: 11.55 - 12.35',
                 attributes : {
                        Speaker: 'Mark DiCristina - MailChimp',
                        Details: 'Who says email marketing is dead? In this session MailChimp will guide you through the best practices of email marketing giving you proven real world advice to make your campaigns more effective, profitable and measurable.'},
                    children : []
            },
            {
                 type: 'Detail',
                 title: 'Partner Presentation',
                 subtitle: 'Track 01: 12.35 - 12.55',
                 attributes : {
                        Speaker: 'TBC'
                 },
                 children : []
            },
            {
                type: 'Detail',
                title: 'iPad',
                subtitle: 'Track 02: 12.35 - 12.55',
                attributes : {
                       Speaker: 'TBC'
                },
                children : []
            },
            {
                type: 'Detail',
                title: '=== Lunch ===',
                subtitle: '12.55 - 14.25',
                attributes : {
                    Details: 'Break for lunch on us. Networking, some time to catch up with each other, and a bit of a breather before the afternoon sessions start up!'
                },
                children : []
            }                      
            ]
        },
        {
            type: 'List',
            title: 'Conference Day 02',
            subtitle: '05 October, 2010',
            attributes : {},
            children : []
        },
        {
            type: 'List',
            title: 'Workshops Day',
            subtitle: '06 October, 2010',
            attributes : {},
            children : []
        }   
        ]
    }
  }, function(error, pages){});

exports.PageProvider = PageProvider;
