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
            var toggleStar = function(button, eventObject) {
                var title = record.attributes.record.data.title;
                if(localStorage.getItem(title)) {
                    localStorage.removeItem(title);	
                    eventObject.target.parentElement.parentElement.firstChild.className = 'x-component detailspanel x-scroller-parent x-docked x-docked-undefined';
                } else {
                    localStorage.setItem(title, "record.data.title"); 
                    eventObject.target.parentElement.parentElement.firstChild.className = 'x-component detailspanel staron x-scroller-parent x-docked x-docked-undefined';                }
            }
            
            var clazz = 'detailspanel';
            if(localStorage.getItem(record.attributes.record.data.title)) {
                clazz += ' staron';
            } 
            var comp =  new Ext.Component({
                title: 'Details',
                layout : 'fit',
                docked: 'top',
                scroll: 'vertical', 
                cls: clazz, 
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
                    comp
                    ,{text: "Star", xtype: 'button', handler: toggleStar, dock: 'bottom', cls: 'starbutton'}
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
        var refreshStars = function() {
            var listitems = Ext.DomQuery.select('.x-list-item');
            console.log(listitems.length);
            for (var i=0; i < listitems.length; i++) {
                var title = listitems[i].firstChild.firstChild.firstChild.innerText;
                if(localStorage.getItem(title)) {
                    listitems[i].className = 'staron x-list-item';
                } else {
                    listitems[i].className = 'x-list-item';                    
                }
            };            
        };
        /*
        
        list.on('activate', function() {
            console.log('activate');
            refreshStars();
        });
        list.on('show', function() {
            console.log('show');
            refreshStars();
        });
        list.on('beforeshow', function() {
            console.log('beforeshow');
            refreshStars();
        });
        list.on('enable', function() {
            console.log('enable');
            refreshStars();
        });
        list.on('add', function() {
            console.log('add');
            refreshStars();
        });
        
        list.on('afterlayout', function() {
            console.log('afterlayout');
            refreshStars();
        });
        list.on('render', function() {
            console.log('render');
            refreshStars();            
        });
        list.on('afterrender', function() {
            console.log('afterrender');
            refreshStars();            
        });
        */
        list.on('beforecardswitch', function() {
            refreshStars();
        });
                
        var main = new Ext.Panel({
            fullscreen: true,
            layout: 'card',
            items: [list]
        });
        
    }
})