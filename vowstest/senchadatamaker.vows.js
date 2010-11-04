require.paths.unshift('vendor/testlib');

var vows = require('vows'),
    assert = require('assert'),
    http = require('http');
    
var SenchaDataMaker = require('../lib/senchadatamaker').SenchaDataMaker;
var senchadatamaker = new SenchaDataMaker();

vows.describe('senchadatamaker')
.addBatch({
    'senchadatamaker is configured': {
        topic: function(){ return senchadatamaker },
        'app is not null': function (senchadatamaker) {
            assert.isNotNull (senchadatamaker);
        }
    }
})
.addBatch({
    'insertGroupsFromSpacers': {
        topic: function(){ 
            var data = { 
                title: 'test1',
                children: [ 
                    { type: 'Spacer', title: 'groupa'},
                    { title: 'Child2', children: [
                        { type: 'Spacer', title: 'groupb'},
                        { title: 'Child2b'},
                    ] },
                    { title: 'Child3'}
                ]
            };
            return senchadatamaker.insertGroupsFromSpacers(data); 
        },
        'data is filled with groups': function (dataWithGroups) {
            assert.equal (dataWithGroups.title, 'test1');
            assert.equal (dataWithGroups.children.length, 2);
            assert.equal (dataWithGroups.children[0].group, 'groupa');
            assert.equal (dataWithGroups.children[1].group, 'groupa');
            assert.equal (dataWithGroups.children[0].children.length, 1);
            assert.equal (dataWithGroups.children[0].children[0].group, 'groupb');
            
        }
    }
})

/*
{ _id: { id: 'L\u00d1\u0093Sh<E=!\u0000\u0000\u0001' }
, userid: null
, rootpage: 
   { title: 'test123'
   , type: 'Navigation'
   , children: 
      [ [Object]
      , [Object]
      , [Object]
      , [Object]
      , [Object]
      , [Object]
      , [Object]
      ]
   , attributes: []
   }
}
*/
.export(module)