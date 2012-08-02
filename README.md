Description
===========

Installs WebLogic.

Requirements
============

Platform
--------

* Windows 

Attributes
==========

See `attributes/default.rb` for default values.

* `node['weblogic']['bea_home']` - Complete pathname to the Middleware Home directory that will contain this installation.
* `node['weblogic']['wls_install_dir']` - Complete pathname to the product installation directory in which to install WebLogic Server.

Recipes
=======

default
-------

Include the default recipe in a run list to get `weblogic`.

Usage
=====

Simply include the `weblogic` recipe wherever you would like WebLogic
installed.

