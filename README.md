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

## Post Installation Configurations

### Enable PHP5 Opcache

For Apache server located in `/etc/php5/apache2/php.ini`:
 - Enable the Opcache `opcache.enable=1`
 - Modify the Amount of RAM the Opcache Will Use `opcache.memory_consumption=128`
 - Boost the Number of Scripts that Can Be Cached `opcache.max_accelerated_files=4000`
 - Change the Revalidate Frequency `opcache_revalidate_freq = 240`

 Afterwards, verify that opcache is enabled `sudo php5enmod opcache` and restart Apache `sudo service nginx restart`

Ref: http://www.hostingadvice.com/how-to/enable-php-5-5-opcache-ubuntu-14-04/

### Enable ModSec

> Debugging and ensuring Modsec is installed can be done via `sudo apachectl -M | grep --color security2`

- Enable `SecRuleEngine` by setting it to **On** in `/etc/modsecurity/modsecurity.conf`

There are two configurations files for the rules `/etc/apache2/mods-enabled/modsecurity.conf` and `/etc/apache2/mods-enabled/security2.conf`

**modsecurity.conf**

```bash
<IfModule security2_module>
    Include /usr/share/modsecurity-crs/*.conf
</IfModule>
```

**security2.conf**

```bash
<IfModule security2_module>
 # Default Debian dir for modsecurity's persistent data
 SecDataDir /var/cache/modsecurity

 # Include all the *.conf files in /etc/modsecurity.
 # Keeping your local configuration in that directory
 # will allow for an easy upgrade of THIS file and
 # make your life easier
  IncludeOptional /etc/modsecurity/*.conf
  IncludeOptional /usr/share/modsecurity-crs/activated_rules/*.conf
</IfModule>
```

Now, we need to link the appropriate `.conf` files :

Navigate to `/usr/share/modsecurity-crs/activated_rules/` and execute:

 - `ln -s /usr/share/modsecurity-crs/base_rules/*.* .`
 - `ln -s /usr/share/modsecurity-crs/optional_rules/*.* .`
 - `ln -s /usr/share/modsecurity-crs/experimental_rules/*.* .`
 - `ln -s /usr/share/modsecurity-crs/slr_rules/*.* .`

Then debug via the `sudo apachectl -M | grep --color security2` and removed conflicting configuration files.

### Excluding Directories/Domains (Optional)

Sometimes it makes sense to exclude a particular directory or a domain name if it is running an application, like phpMyAdmin, as ModSecurity will block SQL queries. It is also better to exclude admin backends of CMS applications like WordPress. If you're following this tutorial on a fresh server, you can skip this step.

To disable ModSecurity for a complete VirtualHost, place the following directives inside the `<VirtualHost>[...]</VirtualHost>` block in its virtual host file.

```bash
<IfModule security2_module>
    SecRuleEngine Off
</IfModule>
```

For omitting a particular directory:

```bash
<Directory "/var/www/wp-admin">
    <IfModule security2_module>
        SecRuleEngine Off
    </IfModule>
</Directory>
```

### Download Geo DB for rules set

 - Navigate to `/usr/share/` and download the DB by `wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz`
 - Then unzip the DB `gunzip GeoIP.dat.gz`
 - Move the DB to its corresponding folder `mv GeoIP.dat /usr/share/GeoIP/`
 - You might want to do this as well for the GeoLityCity DB at `http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz`

### Configure PHPmyadmin

To set up under Apache all you need to do is include the following line in `/etc/apache2/apache2.conf`

```bash
Include /etc/phpmyadmin/apache.conf
```

Once phpMyAdmin is installed point your browser to `http://localhost/phpmyadmin` to start using it. You should be able to login using any users you've setup in MySQL. If no users have been setup, use admin with no password to login.

Should you get a **404** "Not Found" error when you point your browser to the location of phpMyAdmin (such as: `http://localhost/phpmyadmin`) the issue is likely caused by not checking the 'Apache 2' selection during installation. To redo the installation run the following:

```bash
sudo dpkg-reconfigure -plow phpmyadmin
```

>When the first prompt appears, apache2 is highlighted, but not selected. If you do not hit "SPACE" to select Apache, the installer will not move the necessary files during installation. Hit "SPACE", "TAB", and then "ENTER" to select Apache.

Unfortunately older versions of phpMyAdmin have had serious security vulnerabilities including allowing remote users to eventually exploit root on the underlying virtual private server. One can prevent a majority of these attacks through a simple process: locking down the entire directory with Apache's native user/password restrictions which will prevent these remote users from even attempting to exploit older versions of phpMyAdmin.

### Set Up the .htaccess File

To set this up start off by allowing the .htaccess file to work within the phpmyadmin directory. You can accomplish this in the phpmyadmin configuration file:

    sudo nano /etc/phpmyadmin/apache.conf

Under the directory section, add the line "AllowOverride All" under "Directory Index", making the section look like this:

    <Directory /usr/share/phpmyadmin>
            Options FollowSymLinks
            DirectoryIndex index.php
            AllowOverride All
            [...]

### Configure the .htaccess file

With the .htaccess file allowed, we can proceed to set up a native user whose login would be required to even access the phpmyadmin login page.

Start by creating the .htaccess page in the phpmyadmin directory:

    sudo nano /usr/share/phpmyadmin/.htaccess

Follow up by setting up the user authorization within .htaccess file. Copy and paste the following text in:

    AuthType Basic
    AuthName "Restricted Files"
    AuthUserFile /etc/apache2/.phpmyadmin.htpasswd
    Require valid-user

Below you'll see a quick explanation of each line

* **AuthType:** This refers to the type of authentication that will be used to the check the passwords. The passwords are checked via HTTP and the keyword Basic should not be changed.
* **AuthName:** This is text that will be displayed at the password prompt. You can put anything here.
* **AuthUserFile:** This line designates the server path to the password file (which we will create in the next step.)
* **Require valid-user:** This line tells the .htaccess file that only users defined in the password file can access the phpMyAdmin login screen.

### Create the htpasswd file

Now we will go ahead and create the valid user information.

Start by creating a htpasswd file. Use the htpasswd command, and place the file in a directory of your choice as long as it is not accessible from a browser. Although you can name the password file whatever you prefer, the convention is to name it .htpasswd.

    sudo htpasswd -c _/etc/apache2/.phpmyadmin.htpasswd_ _username_

A prompt will ask you to provide and confirm your password.

Once the username and passwords pair are saved you can see that the password is encrypted in the file.

FInish up by restarting apache:

    sudo service apache2 restart

## Accessing phpMyAdmin

phpMyAdmin will now be much more secure since only authorized users will be able to reach the login page. Accessing youripaddress/phpmyadmin should display a screen like [this][4].

Fill it in with the username and password that you generated. After you login you can access phpmyadmin with the MySQL username and password.

## References

 - [How To Install, Configure, And Use Modules In The Apache Web Server] (https://www.digitalocean.com/community/tutorials/how-to-install-configure-and-use-modules-in-the-apache-web-server)
 - [How to Get Started With mod_pagespeed with Apache on an Ubuntu and Debian Cloud Server](https://www.digitalocean.com/community/tutorials/how-to-get-started-with-mod_pagespeed-with-apache-on-an-ubuntu-and-debian-cloud-server)
 - [How To Set Up ModSecurity with Apache ](https://www.digitalocean.com/community/tutorials/how-to-set-up-modsecurity-with-apache-on-ubuntu-14-04-and-debian-8)
 - [How To Install and Secure phpMyAdmin ](https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-on-ubuntu-14-04)
 - [How To Set Up Mod_Rewrite](https://www.digitalocean.com/community/tutorials/how-to-set-up-mod_rewrite)
