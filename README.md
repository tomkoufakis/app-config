Configure your Node.js Applications
===================================

[![NPM](https://nodei.co/npm/nm-config.svg?downloads=true&downloadRank=true)](https://nodei.co/npm/nm-config/)&nbsp;&nbsp;
[![Build Status](https://secure.travis-ci.org/tomkoufakis/nm-config.svg?branch=master)](https://travis-ci.org/tomkoufakis/nm-config)&nbsp;&nbsp;
[release notes](https://github.com/tomkoufakis/nm-config/blob/master/History.md)

Introduction
------------

nm-config organizes hierarchical configurations for your app deployments.

This repo was forked from [node-config](https://github.com/lorenwest/node-config) and add's additional functionality to allow for multilevel config directories.
This is useful when using config in an npm package where that package will have it's own configuration. Your main application 
can then choose to override those configurations, if it also uses nm-config.

It lets you define a set of default parameters,
and extend them for different deployment environments (development, qa,
staging, production, etc.).

Configurations are stored in [configuration files](https://github.com/lorenwest/node-config/wiki/Configuration-Files) within your application, and can be overridden and extended by [environment variables](https://github.com/lorenwest/node-config/wiki/Environment-Variables),
 [command line parameters](https://github.com/lorenwest/node-config/wiki/Command-Line-Overrides), or [external sources](https://github.com/lorenwest/node-config/wiki/Configuring-from-an-External-Source).

This gives your application a consistent configuration interface shared among a
[growing list of npm modules](https://www.npmjs.org/browse/depended/config) also using node-config.

Project Guidelines
------------------

* *Simple* - Get started fast
* *Powerful* - For multi-node enterprise deployment
* *Flexible* - Supporting multiple config file formats
* *Lightweight* - Small file and memory footprint
* *Predictable* - Well tested foundation for module and app developers

Quick Start
---------------
The following examples are in JSON format, but configurations can be in other [file formats](https://github.com/lorenwest/node-config/wiki/Configuration-Files#file-formats).

**Install in your app directory, and edit the default config file.**

```shell
$ npm install nm-config
$ mkdir config
$ vi config/default.json
```
```js
{
  // Customer module configs
  "Customer": {
    "dbConfig": {
      "host": "localhost",
      "port": 5984,
      "dbName": "customers"
    },
    "credit": {
      "initialLimit": 100,
      // Set low for development
      "initialDays": 1
    }
  }
}
```

**Edit config overrides for production deployment:**

```shell
 $ vi config/production.json
```

```json
{
  "Customer": {
    "dbConfig": {
      "host": "prod-db-server"
    },
    "credit": {
      "initialDays": 30
    }
  }
}
```

**Use configs in your code:**

```js
var config = require('nm-config');
//...
var dbConfig = config.get('Customer.dbConfig');
db.connect(dbConfig, ...);

if (config.has('optionalFeature.detail')) {
  var detail = config.get('optionalFeature.detail');
  //...
}
```

`config.get()` will throw an exception for undefined keys to help catch typos and missing values.
Use `config.has()` to test if a configuration value is defined.

**Start your app server:**

```shell
$ export NODE_ENV=production
$ node my-app.js
```

Running in this configuration, the `port` and `dbName` elements of `dbConfig`
will come from the `default.json` file, and the `host` element will
come from the `production.json` override file.

**using config in submodules/npm packages:**

If your npm package requires custom configuration, you can lay your configuration out
in a hierarchical manner. Your folder structure could look like this:

/
- config
  - default.json
- node_modules
  - my_module
    - config
      - default.json
- index.js

``` json of module default.json
{
  "key1": "value1",
  "key2": "value2"
}
```

``` json of app default.json
{
  "key1": "perent",
  "key3": "value3"
}
```

```js in my_module
var config = require('nm-config').withConfig('./config');
//...
var key1 = config.get('key1'); // key1 = parent
var key2 = config.get('key2'); // key2 = value2
```
```js in app
var config = require('nm-config')
//...
var key3 = config.get('key3'); // key3 = key3
var key2 = config.get('key2'); // key2 = undefined
```

Articles
--------

* [Configuration Files](https://github.com/lorenwest/node-config/wiki/Configuration-Files)
* [Common Usage](https://github.com/lorenwest/node-config/wiki/Common-Usage)
* [Environment Variables](https://github.com/lorenwest/node-config/wiki/Environment-Variables)
* [Reserved Words](https://github.com/lorenwest/node-config/wiki/Reserved-Words)
* [Command Line Overrides](https://github.com/lorenwest/node-config/wiki/Command-Line-Overrides)
* [Multiple Node Instances](https://github.com/lorenwest/node-config/wiki/Multiple-Node-Instances)
* [Sub-Module Configuration](https://github.com/lorenwest/node-config/wiki/Sub-Module-Configuration)
* [Configuring from a DB / External Source](https://github.com/lorenwest/node-config/wiki/Configuring-from-an-External-Source)
* [Securing Production Config Files](https://github.com/lorenwest/node-config/wiki/Securing-Production-Config-Files)
* [External Configuration Management Tools](https://github.com/lorenwest/node-config/wiki/External-Configuration-Management-Tools)
* [Examining Configuration Sources](https://github.com/lorenwest/node-config/wiki/Examining-Configuration-Sources)
* [Using Config Utilities](https://github.com/lorenwest/node-config/wiki/Using-Config-Utilities)
* [Upgrading from Config 0.x](https://github.com/lorenwest/node-config/wiki/Upgrading-From-Config-0.x)

Contributors
------------
<table id="contributors"><tr><td><img src=https://avatars2.githubusercontent.com/u/11436187?v=4><a href="https://github.com/tomkoufakis">tomkoufakis</a></td><td><img src=https://avatars2.githubusercontent.com/u/373538?v=4><a href="https://github.com/lorenwest">lorenwest</a></td><td><img src=https://avatars1.githubusercontent.com/u/25829?v=4><a href="https://github.com/markstos">markstos</a></td><td><img src=https://avatars3.githubusercontent.com/u/447151?v=4><a href="https://github.com/elliotttf">elliotttf</a></td><td><img src=https://avatars0.githubusercontent.com/u/66902?v=4><a href="https://github.com/leachiM2k">leachiM2k</a></td><td><img src=https://avatars1.githubusercontent.com/u/791137?v=4><a href="https://github.com/josx">josx</a></td></tr><tr><td><img src=https://avatars2.githubusercontent.com/u/133277?v=4><a href="https://github.com/enyo">enyo</a></td><td><img src=https://avatars3.githubusercontent.com/u/1077378?v=4><a href="https://github.com/arthanzel">arthanzel</a></td><td><img src=https://avatars2.githubusercontent.com/u/1656140?v=4><a href="https://github.com/eheikes">eheikes</a></td><td><img src=https://avatars0.githubusercontent.com/u/355800?v=4><a href="https://github.com/diversario">diversario</a></td><td><img src=https://avatars3.githubusercontent.com/u/138707?v=4><a href="https://github.com/th507">th507</a></td><td><img src=https://avatars2.githubusercontent.com/u/506460?v=4><a href="https://github.com/Osterjour">Osterjour</a></td></tr><tr><td><img src=https://avatars0.githubusercontent.com/u/842998?v=4><a href="https://github.com/nsabovic">nsabovic</a></td><td><img src=https://avatars0.githubusercontent.com/u/5138570?v=4><a href="https://github.com/ScionOfBytes">ScionOfBytes</a></td><td><img src=https://avatars2.githubusercontent.com/u/2529835?v=4><a href="https://github.com/simon-scherzinger">simon-scherzinger</a></td><td><img src=https://avatars1.githubusercontent.com/u/175627?v=4><a href="https://github.com/axelhzf">axelhzf</a></td><td><img src=https://avatars3.githubusercontent.com/u/7782055?v=4><a href="https://github.com/benkroeger">benkroeger</a></td><td><img src=https://avatars3.githubusercontent.com/u/1443067?v=4><a href="https://github.com/IvanVergiliev">IvanVergiliev</a></td></tr><tr><td><img src=https://avatars1.githubusercontent.com/u/8839447?v=4><a href="https://github.com/jfelege">jfelege</a></td><td><img src=https://avatars2.githubusercontent.com/u/1246875?v=4><a href="https://github.com/jaylynch">jaylynch</a></td><td><img src=https://avatars1.githubusercontent.com/u/145742?v=4><a href="https://github.com/jberrisch">jberrisch</a></td><td><img src=https://avatars1.githubusercontent.com/u/9355665?v=4><a href="https://github.com/kgoerlitz">kgoerlitz</a></td><td><img src=https://avatars3.githubusercontent.com/u/1918551?v=4><a href="https://github.com/nitzan-shaked">nitzan-shaked</a></td><td><img src=https://avatars3.githubusercontent.com/u/3058150?v=4><a href="https://github.com/robertrossmann">robertrossmann</a></td></tr><tr><td><img src=https://avatars2.githubusercontent.com/u/498929?v=4><a href="https://github.com/roncli">roncli</a></td><td><img src=https://avatars2.githubusercontent.com/u/1355559?v=4><a href="https://github.com/superoven">superoven</a></td><td><img src=https://avatars2.githubusercontent.com/u/54934?v=4><a href="https://github.com/wmertens">wmertens</a></td><td><img src=https://avatars3.githubusercontent.com/u/2842176?v=4><a href="https://github.com/XadillaX">XadillaX</a></td><td><img src=https://avatars1.githubusercontent.com/u/4425455?v=4><a href="https://github.com/ncuillery">ncuillery</a></td><td><img src=https://avatars1.githubusercontent.com/u/618330?v=4><a href="https://github.com/adityabansod">adityabansod</a></td></tr><tr><td><img src=https://avatars3.githubusercontent.com/u/270632?v=4><a href="https://github.com/thetalecrafter">thetalecrafter</a></td></tr></table>

License
-------

May be freely distributed under the [MIT license](https://raw.githubusercontent.com/tomkoufakis/nm-config/master/LICENSE).

Copyright (c) 2017 Tom Koufakis 
[and other contributors](https://github.com/tomkoufakis/nm-config/graphs/contributors)

