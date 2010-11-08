Ext.setup({
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    icon: 'icon.png',
    glossOnIcon: false,
    onReady: function(){
        Ext.regModel('TitleSubtitle', {
            fields: ['title', 'subtitle', 'group']
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
            },
            getGroupString : function(record) {
                var group = record.get('group');
                return group || "test";
            }
        });
        
        var detailAttributes = function (record) {
            var tapMe = function() {
                console.log('setItem ' + record.attributes.record.data.title)
                localStorage.setItem(record.attributes.record.data.title, "record.data.title");
            }
            var comp =  new Ext.Component({
                title: 'Details',
                layout : 'fit',
                docked: 'top',
                scroll: 'vertical', 
                cls: 'detailspanel', 
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
                title: 'sss',
                layout : 'fit',
                dockedItems: [
                    comp,
                    {text: "Star", xtype: 'button', handler: tapMe, dock: 'bottom', cls: 'starbutton'}
                ]
            });
            return panel;
        };
        
        var list = new Ext.GroupedNestedList({  
            singleSelect: true,
            grouped: true,
            indexBar: true,
            title: TITLE,
            displayField: 'title',
            //disclosure: false,
            useTitleAsBackText: false,
            store: store,
            getItemTextTpl: function(record) {
                if(record.attributes.record) {
                    var key = record.attributes.record.data.title;
                    if(localStorage.getItem(key)) clazz += " staron";
                }
                return '<tpl for="."><div class="mylistitem"><em>{title}</em><br/> {subtitle}</div></tpl>';
            },
            getDetailCard: function (record, parentrecord) {
                return detailAttributes(record);
            }
        });
        list.on('leafitemtap', function(node) {
            this.toolbar.setTitle(node.store.data.items[0].data.title);
            this.backButton['show']()
        });
        /*
        list.on('activate', function() {
            console.log('activate');
        });
        list.on('render', function() {
            console.log('render');
        });
        list.on('beforecardswitch', function() {
            var listitems = Ext.DomQuery.select('.mylistitem');
            console.log('beforecardswitch');
            console.log(listitems);
            for (var i=0; i < listitems.length; i++) {
                var title = Ext.DomQuery.select(listitems[i], 'em')
                console.log('title' + tile);
            };
        });
        */
                
        var main = new Ext.Panel({
            fullscreen: true,
            layout: 'card',
            items: [list]
        });
        
    }
})