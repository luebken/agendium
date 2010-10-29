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
        
        var list = new Ext.NestedList({   
            singleSelect: true,
            grouped: true,
            indexBar: true,
            //disclosure: false,
            //useTitleAsBackText: true,
            store: store,
            getItemTextTpl: function() {
                return '<tpl for="."><div class="mylistitem"><em>{title}</em><br/> {subtitle}</div></tpl>';
            }
        });
        
        var main = new Ext.Panel({
            fullscreen: true,
            layout: 'card',
            items:[list]
        });
    }
})