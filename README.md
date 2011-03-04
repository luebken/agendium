Server
------
* Run 'startmongo.sh' & 'node server.js'
* Open http://localhost:8000/

Tests
------
* Run 'startmongo.sh' & 'runvowstests.sh'
* cd client-src & 'jake test'


Client Development
------
* Install Atlas http://280atlas.com/
* Open client-src/
* Click Run
* Or install Jake run 'jake run'

Client Deployment
------
* Build with Atlas or jake
* Copy Release\Desktop Browser\Project to lib\public\Project
* cp -r Build/Release/agendium/* ../lib/public/Project/

Joyent
-----
* ssh node@72.2.126.80
* http://wiki.joyent.com/display/node/Node.js+SmartMachine+FAQ#Node.jsSmartMachineFAQ-IneedtopasssomeAPIcredentialstomynode.jsprocess
* svccfg -s node-service setenv 'MONGOHQ_URL' 'mongodb://127.0.0.1:27017/agendium'
* bin/mongod --dbpath /home/node/mongo/databases/ --bind_ip 127.0.0.1 --logpath /home/node/mongo.log --fork


Upgrade TODOs:
===
* jQmobile 1.0.0 umstellen
* Exress 2.0

Dev TODOs:
===
* Warum postet CAPP mit xml bei save agenda?
* Node aufräumen und besser testen
* Cappuccino aufräumen und besser testen

Features / Bugs
=====
* Scrollbar nur ganz aussen
* Spacer => Group umbennend
* Typ ändern Detail => Content
* Kopieren von Items
* New-Template
* iphone preview
* nach Safe nicht zurück springen
* New Wizard from Dates
* Pagetyp: Tweetwall
* Tweet from Details 
* Favourites
* Notes
* Pagetype: rss-feed