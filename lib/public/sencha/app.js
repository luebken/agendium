Ext.setup({
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    icon: 'icon.png',
    glossOnIcon: false,
    onReady: function(){
        Ext.regModel('TitleSubtitle', {
            fields: ['title', 'subtitle']
        });
        
        var store = new Ext.data.TreeStore({
            model: 'TitleSubtitle',
            storeid : 'datastore', 
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
            var tapMe = function() {
                localStorage.setItem(record.attributes.record.data.title, "record.data.title");
            }
            var comp =  new Ext.Component({
                title: 'Details',
                cls: 'details',
                layout : 'fit',
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
            var panel = new Ext.Panel({
                fullscreen: true,
                layout : 'vbox',
                items: [
                    comp,
                    {text: "Star", xtype: 'button', handler: tapMe}
                ]
            });
            return panel;
        };
        
        var list = new Ext.NestedList({   
            title: 'Main',
            singleSelect: true,
            grouped: true,
            indexBar: true,
            //disclosure: false,
            //useTitleAsBackText: true,
            store: store,
            getItemTextTpl: function(record) {
                var clazz = "mylistitem";
                if(record.attributes.record) {
                    var key = record.attributes.record.data.title;
                    if(localStorage.getItem(key)) clazz += " staron";
                }
                return '<tpl for="."><div class="'+clazz+'"><em>{title}</em><br/> {subtitle}</div></tpl>';
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