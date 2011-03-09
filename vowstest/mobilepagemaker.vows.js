require.paths.unshift('vendor/testlib');
require.paths.unshift('vendor/lib');
require.paths.unshift('lib');

var vows = require('vows'),
    assert = require('assert'),
    sys = require('sys'),
    htmlparser = require('htmlparser');

var MobilePageMaker = require('controller/agenda/mobilepagemaker').MobilePageMaker;
var mobilePageMaker = new MobilePageMaker();

var parse = function(rawHtml) {
    var handler = new htmlparser.DefaultHandler();
    var parser = new htmlparser.Parser(handler);
    parser.parseComplete(rawHtml);
    return handler.dom;
}

vows.describe('MobilePageMaker')
.addBatch({
    'when provided an empty page': {
        topic: mobilePageMaker.pages({
            rootpage : {
                type : 'Navigation',
                title: 'Sample tile',
                children : []
            }
        })
        ,
        'it should create a page with a header and a content': function(html) {
            var dom = parse(html);
            var root_tag = dom[0];
            assert.equal(root_tag.attribs.id, 'r');
            assert.equal(root_tag.attribs['data-role'], 'page');
            var header = root_tag.children[0];
            assert.equal(header.attribs['data-role'], 'header');
            var content = root_tag.children[1];
            assert.equal(content.attribs['data-role'], 'content');
        }
        ,
        'the content should have an empty list': function(html) {
            var dom = parse(html);
            var content = dom[0].children[1];
            var ul = content.children[0];
            assert.equal(ul.attribs['data-role'], 'listview');
            assert.isUndefined(ul.children);
        }
    }
})
.addBatch({
    'when provided an page with two navigation children': {
        topic: mobilePageMaker.pages({
            rootpage : {
                type : 'Navigation',
                title: 'Sample tile',
                children : [
                    {
                        type : 'Navigation',
                        title: 'Sample subtitle 1',
                        children : []
                    },
                    {
                        type : 'Navigation',
                        title: 'Sample subtitle 2',
                        children : []
                    }
                ]
            }
        })
        ,
        'the content should have a list with two items': function(html) {
            var dom = parse(html);
            var content = dom[0].children[1];
            var ul = content.children[0];
            assert.equal(2, ul.children.length);
        }
        ,
        'the first item should link to first subpage': function(html) {
            var dom = parse(html);
            var content = dom[0].children[1];
            var ul = content.children[0];
            var li1 = ul.children[0];
            assert.equal('li', li1.name)
            assert.equal('a', li1.children[0].name)
            assert.equal('#rc0', li1.children[0].attribs.href)            
        }
        ,
        'the second item should link to second subpage': function(html) {
            var dom = parse(html);
            var content = dom[0].children[1];
            var ul = content.children[0];
            var li2 = ul.children[1];
            assert.equal('li', li2.name)
            assert.equal('a', li2.children[0].name)
            assert.equal('#rc1', li2.children[0].attribs.href)            
        }
        ,
        'the first page should be inserted': function(html) {
            var dom = parse(html);
            var first_page = dom[1];
            assert.equal(first_page.attribs.id, 'rc0');
            assert.equal(first_page.attribs['data-role'], 'page');
            var header = first_page.children[0];
            assert.equal(header.attribs['data-role'], 'header');
            var content = first_page.children[1];
            assert.equal(content.attribs['data-role'], 'content');         
        }
        ,
        'the second page should be inserted': function(html) {
            var dom = parse(html);
            var second_page = dom[2];
            assert.equal(second_page.attribs.id, 'rc1');
            assert.equal(second_page.attribs['data-role'], 'page');
            var header = second_page.children[0];
            assert.equal(header.attribs['data-role'], 'header');
            var content = second_page.children[1];
            assert.equal(content.attribs['data-role'], 'content');         
        }
    }
})
.export(module)