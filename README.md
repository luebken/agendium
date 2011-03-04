Server
------
* Install node.js
* Run 'node server.js'
* Give it a try http://localhost:8000/a/0

Server-Tests
------
* Install Expresso
* Run 'expresso tests/*'
* Or with Vows: 'vows vowstest/*' 
* Not decided yet



Client
------
* Open http://localhost:8000/
* Enter 'test' as app name and hit load

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
ssh node@72.2.126.80
http://wiki.joyent.com/display/node/Node.js+SmartMachine+FAQ#Node.jsSmartMachineFAQ-IneedtopasssomeAPIcredentialstomynode.jsprocess
[node@touchium ~]$ svccfg -s node-service setenv 'MONGOHQ_URL' 'mongodb://admin:sehrgeheim123:127.0.0.1:27017/agendium'

http://www.mongodb.org/display/DOCS/Security+and+Authentication
db.addUser("admin", "sehrgeheim123")
5e471e24f89ecfe2bdb1f2fce8d8c059
db.auth("admin", "pEfAswen7TasafRu")


MAIN TODOs
=====
* Warum postet CAPP mit xml?
haml zum laufen bringen oder auf jade umstellen
 - http://localhost:8000/preview

* auf 0.4.1 testen
* auf node deployen
* cappuccino upgrade
* node aufräumen 
* cappuccino aufräumen 

Features / Bugs
=====
Feature:
- Spacer => Group umbennend
- Typ ändern Detail => Content
- Kopieren von Items

* New-Template
* iphone preview
* nach Safe nicht zurück springen
* New Wizard from Dates
* Pagetyp: Tweetwall
* Tweet from Details 
* Favourites
* Notes
* Pagetype: rss-feed