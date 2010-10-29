Ext.setup({
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    icon: 'icon.png',
    glossOnIcon: false,
    onReady: function(){
        Ext.regModel('Cars', {
            fields: [
                'title', 'subtitle'
            ]
        });
        
        var store = new Ext.data.TreeStore({
            model: 'Cars',
            proxy: {
                type: 'ajax',
                url: DATA_URL,
                reader: {
                    type: 'tree',
                    root: 'items'
                }
            }
        });
        
        var detailAttributes = function (record) {
            var comp =  new Ext.Component({
                title: 'Details',
                cls: 'details',
                scroll: 'vertical',
                tpl: [
                    '<tpl for=".">',
                        '<div class="details">',
                                '<div class="attribute">',
                                    '<h2>{title}</h2>',
                                    '<p>{subtitle}</p>',
                                '</div>',
                        '</div>',
                    '</tpl>'
                ]
            });
            var attributes = [];
            for(var i=0; i<record.childNodes.length; i++) {
                var title = record.childNodes[i].attributes.record.data.title;
                var subtitle = record.childNodes[i].attributes.record.data.subtitle;
                attributes.push({'title':title,'subtitle':subtitle })
            }
            comp.update(attributes);
            return comp;
        };
        
        var list = new Ext.NestedList({   
            title: 'Main',
            singleSelect: true,
            grouped: true,
            indexBar: true,
            //disclosure: false,
            //useTitleAsBackText: true,
            store: store,
            getItemTextTpl: function() {
                return '<tpl for="."><div class="mylistitem"><em>{title}</em><br/> {subtitle}</div></tpl>';
            },
            getDetailCard: function (record, parentrecord) {
                return detailAttributes(record);
            }
        });
                
        var main = new Ext.Panel({
            fullscreen: true,
            layout: 'card',
            items: [list]
        });
        
    }
})