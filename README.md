# My Linux Machine Configurations

This repo is a minimzed version of my [main configurations repo](https://github.com/ahmadassaf/configurations) dedicated for my personal OSX machine. The intention for this repo is to bootstrap a dev environment in my remote Ubuntu Server.

At first, we need to install `git` at our server. To do that:

```
sudo apt-get update
sudo apt-get install git
```

Afterwards, navigate to a directory of choice e.g. `/var/` and clone this repository with:

`git clone http://github.com/ahmadassaf/configurations_linux`

Afterwards, simply run `bash install.sh` and you will be guided through the installation process.

## Installing Additional Software

To install various software in the server, run `bash install post-install.sh`. This will install:

 - LAMP Stack (Apache, MySQL and PHP)
 - JAVA JRE and JDK
 - [Jenkins](jenkins-ci.org)
 - Node.js
 - NPM
 - [JUJU](https://jujucharms.com/)
 - MongoDB

There are a bunch of useful Node.js command line tools that can be installed globally. For that, the file `.npm_globals.sh` define an array of those applications. The script will then also install a set of NPM Globals:

+ [**amok**](https://www.npmjs.com/package/amok): A free open source, editor agnostic, cross-platform command line tool for fast incremental development, testing and debugging in web browsers
+ [**bower**](https://www.npmjs.com/package/bower): Bower offers a generic, unopinionated solution to the problem of front-end package management, while exposing the package dependency model via an API that can be consumed by a more opinionated build stack
+ [**caniuse**](https://www.npmjs.com/package/caniuse): Compatibility validation for support of HTML5, CSS3, SVG and more in desktop and mobile browsers
+ [**eslint**](https://www.npmjs.com/package/eslint): ESLint is a tool for identifying and reporting on patterns found in ECMAScript/JavaScript code
+ [**grunt**](https://www.npmjs.com/package/grunt): The JavaScript Task Runner
+ [**imageoptim**](https://www.npmjs.com/package/imageoptim): Node.js wrapper for some images compression algorithms
+ [**jscs**](https://www.npmjs.com/package/jscs): JavaScript Code Style
+ [**mocha**](https://www.npmjs.com/package/mocha): Simple, flexible, fun test fr**amework
+ [**nodemon**](https://www.npmjs.com/package/nodemon): Nodemon will watch the files in the directory in which nodemon was started, and if any files change, nodemon will automatically restart your node application.
+ [**prettyjson**](https://www.npmjs.com/package/prettyjson): Package for formatting JSON data in a coloured YAML-style, perfect for CLI output
+ [**psi**](https://www.npmjs.com/package/psi): PageSpeed Insights with reporting
+ [**should**](https://www.npmjs.com/package/should): Should is an expressive, readable, framework-agnostic assertion library. The main goals of this library are to be expressive and to be helpful. It keeps your test code clean, and your error messages helpful.
+ [**slap**](https://www.npmjs.com/package/slap): Slap is a Sublime-like terminal-based text editor that strives to make editing from the terminal easier
+ [**sparkly**](https://www.npmjs.com/package/sparkly): Generate sparklines
+ [**tmi**](https://www.npmjs.com/package/tmi): Find out the image weight in your pages, compare to the BigQuery quantiles and discover what images you can optimize further
+ [**vtop**](https://www.npmjs.com/package/vtop): A graphical activity monitor for the command line

