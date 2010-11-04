/**
 * @class Ext.GroupedNestedList
 * @extends Ext.Panel
 *
 * 
GroupedNestedList provides a miller column interface to navigate between nested sets
 * and provide a clean interface with limited screen real-estate.


 *
 * 

// store with data
var data = {
    text: 'Groceries',
    items: [{
        text: 'Drinks',
        items: [{
            text: 'Water',
            items: [{
                text: 'Sparkling',
                leaf: true
            },{
                text: 'Still',
                leaf: true
            }]
        },{
            text: 'Coffee',
            leaf: true
        },{
            text: 'Espresso',
            leaf: true
        },{
            text: 'Redbull',
            leaf: true
        },{
            text: 'Coke',
            leaf: true
        },{
            text: 'Diet Coke',
            leaf: true
        }]
    },{
        text: 'Fruit',
        items: [{
            text: 'Bananas',
            leaf: true
        },{
            text: 'Lemon',
            leaf: true
        }]
    },{
        text: 'Snacks',
        items: [{
            text: 'Nuts',
            leaf: true
        },{
            text: 'Pretzels',
            leaf: true
        },{
            text: 'Wasabi Peas',
            leaf: true
        }]
    },{
        text: 'Empty Category',
        items: []
    }]
};
Ext.regModel('ListItem', {
    fields: [{name: 'text', type: 'string'}]
});
var store = new Ext.data.TreeStore({
    model: 'ListItem',
    root: data,
    proxy: {
        type: 'ajax',
        reader: {
            type: 'tree',
            root: 'items'
        }
    }
});
var nestedList = new Ext.GroupedNestedList({
    fullscreen: true,
    title: 'Groceries',
    displayField: 'text',
    store: store
});

 *
 * @xtype nestedlist
 */
Ext.GroupedNestedList = Ext.extend(Ext.Panel, {
    cmpCls: 'x-nested-list',
    
/**
     * @cfg {String} layout
     * @hide
     */
    layout: 'card',

    
/**
     * @cfg {String} tpl
     * @hide
     */

    
/**
     * @cfg {String} defaultType
     * @hide
     */

    // Putting this in getSubList otherwise users would have to explicitly
    // specify the xtype to create in getDetailCard
    //defaultType: 'list',

    
/**
     * @cfg {String} animation
     * Animation to be used during transitions of cards.
     * Any valid value from Ext.anims can be used ('fade', 'slide', 'flip', 'cube', 'pop', 'wipe').
     * Defaults to 'slide'.
     */
    animation: 'slide',

    
/**
     * @type Ext.Button
     */
    backButton: null,

    
/**
     * @cfg {String} backText
     * The label to display for the back button. Defaults to "Back".
     */
    backText: 'Back',

    
/**
     * @cfg {Boolean} useTitleAsBackText
     */
    useTitleAsBackText: true,

    
/**
     * @cfg {Boolean} updateTitleText
     * Update the title with the currently selected category. Defaults to true.
     */
    updateTitleText: true,

    
/**
     * @cfg {String} displayField
     * Display field to use when setting item text and title.
     * This configuration is ignored when overriding getItemTextTpl or
     * getTitleTextTpl for the item text or title. (Defaults to 'text')
     */
    displayField: 'text',

    
/**
     * @cfg {String} loadingText
     * Loading text to display when a subtree is loading.
     */
    loadingText: 'Loading...',

    
/**
     * @cfg {String} emptyText
     * Empty text to display when a subtree is empty.
     */
    emptyText: 'No items available.',

    
/**
     * @cfg {Boolean/Function} disclosure
     * Maps to the Ext.List disclosure configuration for individual lists. (Defaults to false)
     */
    disclosure: false,

    
/**
     * @cfg {Boolean/Number} clearSelectionDefer
     * Number of milliseconds to show the highlight when going back in a list. (Defaults to 200).
     * Passing false will keep the prior list selection.
     */
    clearSelectionDefer: 200,


    /**
    * Added by MDL Matthias Lübken
    *
    */
    grouped: false,
/**
     * Override this method to provide custom template rendering of individual
     * nodes. The template will receive all data within the Record and will also
     * receive whether or not it is a leaf node.
     * @param {Ext.data.Record} node
     */
    getItemTextTpl: function(node) {
        return '{' + this.displayField + '}';
    },

    
/**
     * Override this method to provide custom template rendering of titles/back
     * buttons when useTitleAsBackText is enabled.
     * @param {Ext.data.Record} node
     */
    getTitleTextTpl: function(node) {
        return '{' + this.displayField + '}';
    },

    // private
    renderTitleText: function(node) {
        // caching this on the record/node
        // could store in an internal cache via id
        // so that we could clean it up
        if (!node.titleTpl) {
            node.titleTpl = new Ext.XTemplate(this.getTitleTextTpl(node));
        }
        var record = node.getRecord();
        if (record) {
            return node.titleTpl.applyTemplate(record.data);
        } else if (node.isRoot) {
            return this.title || this.backText;
        // 
        } else {
            throw "No RecordNode passed into renderTitleText";
        }
        // 
    },

    
/**
     * @property toolbar
     * Ext.Toolbar shared across each of the lists.
     * This will only exist when useToolbar is true which
     * is the default.
     */
    useToolbar: true,

    
/**
     * @property store
     * Ext.data.TreeStore
     */

    
/**
     * @cfg {Ext.data.TreeStore} store
     * The {@link Ext.data.TreeStore} to bind this GroupedNestedList to.
     */

    
/**
     * Implement getDetailCard to provide a final card for leaf nodes when useDetailCard
     * is enabled. getDetailCard will be passed the currentRecord and the parentRecord.
     * The default implementation will return false
     * @param {Ext.data.Record} record
     * @param {Ext.data.Record} parentRecord
     */
    getDetailCard: function(recordNode, parentNode) {
        return false;
    },

    initComponent : function() {
        var store    = Ext.StoreMgr.lookup(this.store),
            rootNode = store.getRootNode(),
            title    = rootNode.getRecord() ? this.renderTitleText(rootNode) : this.title || '';

        this.store = store;

        if (this.useToolbar) {
            // Add the back button
            this.backButton = new Ext.Button({
                text: this.backText,
                ui: 'back',
                handler: this.onBackTap,
                scope: this,
                // First stack doesn't show back
                hidden: true
            });
            if (!this.toolbar || !this.toolbar.isComponent) {
                
/**
                 * @cfg {Object} toolbar
                 * Configuration for the Ext.Toolbar that is created within the Ext.GroupedNestedList.
                 */
                this.toolbar = Ext.apply({}, this.toolbar || {}, {
                    dock: 'top',
                    xtype: 'toolbar',
                    ui: 'light',
                    title: title,
                    items: []
                });
                this.toolbar.items.unshift(this.backButton);
                this.toolbar = new Ext.Toolbar(this.toolbar);

                this.dockedItems = this.dockedItems || [];
                this.dockedItems.push(this.toolbar);
            } else {
                this.toolbar.insert(0, this.backButton);
            }
        }

        this.items = [this.getSubList(rootNode)];

        Ext.GroupedNestedList.superclass.initComponent.call(this);
        this.on('itemtap', this.onItemTap, this);


        this.addEvents(
            
/**
             * @event itemtap
             * Fires when a node is tapped on
             * @param {Ext.List} list The Ext.List that is currently active
             * @param {Number} index The index of the item that was tapped
             * @param {Ext.Element} item The item element
             * @param {Ext.EventObject} e The event object
             */

            
/**
             * @event itemdoubletap
             * Fires when a node is double tapped on
             * @param {Ext.List} list The Ext.List that is currently active
             * @param {Number} index The index of the item that was tapped
             * @param {Ext.Element} item The item element
             * @param {Ext.EventObject} e The event object
             */

            
/**
             * @event containertap
             * Fires when a tap occurs and it is not on a template node.
             * @param {Ext.List} list The Ext.List that is currently active
             * @param {Ext.EventObject} e The raw event object
             */

            
/**
             * @event selectionchange
             * Fires when the selected nodes change.
             * @param {Ext.List} list The Ext.List that is currently active
             * @param {Array} selections Array of the selected nodes
             */

            
/**
             * @event beforeselect
             * Fires before a selection is made. If any handlers return false, the selection is cancelled.
             * @param {Ext.List} list The Ext.List that is currently active
             * @param {HTMLElement} node The node to be selected
             * @param {Array} selections Array of currently selected nodes
             */

            // new events.
            
/**
             * @event listchange
             * Fires when the user taps a list item
             * @param {Ext.GroupedNestedList} this
             * @param {Object} listitem
             */
            'listchange',

            
/**
             * @event leafitemtap
             * Fires when the user taps a leaf list item
             * @param {Ext.List} subList The subList the item is on
             * @param {Number} subIdx The id of the item tapped
             * @param {Ext.Element} el The element of the item tapped
             * @param {Ext.EventObject} e The event
             * @param {Ext.Panel} card The next card to be shown
             */
            'leafitemtap'
        );
    },

    /**
     * @private
     * Returns the list config for a specified node.
     * @param {HTMLElement} node The node for the list config
     */
    getListConfig: function(node) {
        var itemId = node.internalId,
            emptyText = this.emptyText;

        return {
            itemId: itemId,
            xtype: 'list',
            autoDestroy: true,
            recordNode: node,
            store: this.store.getSubStore(node),
            loadingText: this.loadingText,
            disclosure: this.disclosure,
            grouped: this.grouped, //added my mdl
            displayField: this.displayField,
            singleSelect: true,
            clearSelectionOnDeactivate: false,
            bubbleEvents: [
                'itemtap',
                'containertap',
                'beforeselect',
                'itemdoubletap',
                'selectionchange'
            ],
            itemSelector: '.x-list-item',
            tpl: new Ext.XTemplate(
                '<tpl for="."><div class="x-list-item <tpl if="leaf == true">x-list-item-leaf</tpl>"><span>',
                    this.getItemTextTpl(node),
                '</span></div></tpl>'
            ),

            // Hack to support loadingText
            emptyText: this.loadingText,
            deferEmptyText: false,
            refresh: function() {
                if (this.hasSkippedEmptyText) {
                    this.emptyText = emptyText;
                }
                Ext.List.prototype.refresh.apply(this, arguments);
            }
        };
    },

    
/**
     * Returns the subList for a specified node
     * @param {HTMLElement} node The node for the subList
     */
    getSubList: function(node) {
        var items  = this.items,
            list,
            itemId = node.internalId;

        // can be invoked prior to items being transformed into
        // a MixedCollection
        if (items && items.get) {
            list = items.get(itemId);
        }

        if (list) {
            return list;
        } else {
            return this.getListConfig(node);
        }
    },

    addNextCard: function(recordNode, swapTo) {
        var nextList,
            parentNode   = recordNode ? recordNode.parentNode : null,
            card;

        if (recordNode.leaf) {
            card = this.getDetailCard(recordNode, parentNode);
            if (card) {
                nextList = this.add(card);
            }
        } else {
            nextList = this.getSubList(recordNode);
            nextList = this.add(nextList);
        }
        return nextList;
    },

    setActivePath: function(path) {
        // a forward leading slash indicates to go
        // to root, otherwise its relative to current
        // position
        var gotoRoot = path.substr(0, 1) === "/",
            j        = 0,
            ds       = this.store,
            tree     = ds.tree,
            node, card, lastCard,
            pathArr, pathLn;

        if (gotoRoot) {
            path = path.substr(1);
        }

        pathArr = Ext.toArray(path.split('/'));
        pathLn  = pathArr.length;


        if (gotoRoot) {
            // clear all but first item
            var items      = this.items,
                itemsArray = this.items.items,
                i          = items.length;

            for (; i > 1; i--) {
                this.remove(itemsArray[i - 1], true);
            }

            // verify last item left matches first item in pathArr
            // 
            var rootNode = itemsArray[0].recordNode;
            if (rootNode.id !== pathArr[0]) {
                throw "rootNode doesn't match!";
            }
            // 

            // skip the 0 item rather than remove/add
            j = 1;
        }


        // loop through the path and add cards
        for (; j < pathLn; j++) {
            if (pathArr[j] !== "") {
                node = tree.getNodeById(pathArr[j]);

                // currently adding cards and not verifying
                // that they are true child nodes of the current parent
                // this would be some good debug tags.
                card = this.addNextCard(node);

                // leaf nodes may or may not have a card
                // therefore we need a temp var (lastCard)
                if (card) {
                    lastCard = card;
                }
            }
        }

        // 
        if (!lastCard) {
            throw "Card was not found when trying to add to GroupedNestedList.";
        }
        // 

        this.setCard(lastCard, false);
        this.syncToolbar();
    },

    syncToolbar: function(card) {
        var list          = card || this.getActiveItem(),
            depth         = this.items.indexOf(list),
            recordNode    = list.recordNode,
            parentNode    = recordNode.parentNode,
            backBtn       = this.backButton,
            backBtnText   = this.useTitleAsBackText && parentNode ? this.renderTitleText(parentNode) : this.backText,
            backToggleMth = (depth !== 0) ? 'show' : 'hide';


            if (backBtn) {
                backBtn[backToggleMth]();
                if (parentNode) {
                    backBtn.setText(backBtnText);
                }
            }


            if (this.toolbar && this.updateTitleText) {
                this.toolbar.setTitle(recordNode && recordNode.getRecord() ? this.renderTitleText(recordNode) : this.title || '');
                this.toolbar.doLayout();
            }
    },

    
/**
     * Called when an list item has been tapped
     * @param {Ext.List} subList The subList the item is on
     * @param {Number} subIdx The id of the item tapped
     * @param {Ext.Element} el The element of the item tapped
     * @param {Ext.EventObject} e The event
     */
    onItemTap: function(subList, subIdx, el, e) {
        var store        = subList.getStore(),
            record       = store.getAt(subIdx),
            recordNode   = record.node,
            parentNode   = recordNode ? recordNode.parentNode : null,
            displayField = this.displayField,
            backToggleMth,
            nextDepth,
            nextList;

        nextList = this.addNextCard(recordNode);

        if (recordNode.leaf) {
            this.fireEvent("leafitemtap", subList, subIdx, el, e, nextList);
        }

        if (nextList) {
            // depth should be based off record
            // and TreeStore rather than items.
            nextDepth = this.items.indexOf(nextList);

            this.setCard(nextList, {
                type: this.animation
            });
            this.syncToolbar(nextList);
        }
    },

    
/**
     * Called when the {@link #backButton} has been tapped
     */
    onBackTap: function() {
        var currList      = this.getActiveItem(),
            currIdx       = this.items.indexOf(currList);

        if (currIdx != 0) {
            var prevDepth     = currIdx - 1,
                prevList      = this.items.itemAt(prevDepth),
                recordNode    = prevList.recordNode,
                record        = recordNode.getRecord(),
                parentNode    = recordNode ? recordNode.parentNode : null,
                backBtn       = this.backButton,
                backToggleMth = (prevDepth !== 0) ? 'show' : 'hide',
                backBtnText;

            this.setCard(prevList, {
                type: this.animation,
                reverse: true,
                after: function(el, opts) {
                    this.remove(currList);
                    if (this.clearSelectionDefer) {
                        Ext.defer(prevList.clearSelections, this.clearSelectionDefer, prevList);
                    }
                },
                scope: this
            });
            this.syncToolbar(prevList);
        }
    }
});
Ext.reg('mynestedlist', Ext.GroupedNestedList);