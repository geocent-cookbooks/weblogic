Description
===========

Installs WebLogic.

Requirements
============
* Weblogic install binary
* A Java install

Platform
--------

* Windows 

Attributes
==========

See `attributes/default.rb` for default values.

* `node['weblogic']['bea_home']` - Complete pathname to the Middleware Home directory that will contain this installation.
* `node['weblogic']['wls_install_dir']` - Complete pathname to the product installation directory in which to install WebLogic Server.
* `node['weblogic']['nmgr_securelistener']` - nodemanager SSL listener, defaults to false
* `node['weblogic']['java_home']` - Java install that this Weblogic will use
* `node['weblogic']['java_flavor']` - Determines which Java cookbook to depend on, can be jrockit, java::windows etc.
* `['weblogic']['windows']['package_name']` - the Windows install name

Recipes
=======

default
-------

Include the default recipe in a run list to get `weblogic`.

Usage
=====

Simply include the `weblogic` recipe wherever you would like WebLogic
installed.

