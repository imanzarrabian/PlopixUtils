===================================
Plopix Utils 2.0
===================================

**Author**: morel.seb@gmail.com
**Last Change** : 2011/01/10


------------
Installation
------------

Files
======
 
* copy _lib group under Classes
* copy _config group under Classes
* copy _models group under Classes
* copy _db group under Ressources

Needed framework
================

* CFNetwork
* CoreLocation
* MobileCoreServices
* SystemConfiguration
* libsqlite3.0.dylib
* libz.1.2.3.dylib
* QuartzCore
* MapKit

Configuration 
==============

1) Add theses line in your {$PROJECT_NAME}_Prefix.pch

::

#import "config.h"
#import "PlopixMacros.h"

2) Set your BDD
Rename *PlopixUtils.db* if you want
Set the *BDD_FILENAME* in *config.h*

---------------------------------
Happy to use very usefull library
---------------------------------

- **GoogleAnalytics** : http://code.google.com/mobile/analytics - 0.8
- **ASIHTTPRequest** : http://allseeing-i.com/ASIHTTPRequest - 1.8
- **JSON** : https://github.com/stig/json-framework - 2.3.1

--------------------
And usefull snippets
--------------------

- UIImage+Extensions - *Hardy Macia* - http://www.twitter.com/hardymacia/
- UIImage+Alpha,UIImage+RoundedCorner,UIImage+Resize - *Trevor Harmon* - http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/

