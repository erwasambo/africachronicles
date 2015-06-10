# AFRICA CHRONICLES
###everything africa

##INTRODUCTION

CI3 Fire Starter is a CodeIgniter3 skeleton application that includes jQuery and Bootstrap. It is intended to be light weight, minimalistic and not get in your way of building great CodeIgniter applications. It is also intended for people who want to learn CodeIgniter.

Here is what's included:

* CodeIgniter 3.x
* Single base controller with Public, Private, Admin and API classes
* JSi18n Library to support internationalization in your JS files
* The latest version of jQuery
* The latest version of Bootstrap 3
* Independent admin and frontend themes
* [Summernote](http://summernote.org/ "Summernote") WYSIWYG editor
* Auto-loaded core config file
* Auto-loaded core language file
* Auto-loaded core helper files
    + Human-readable JSON string output for API functions
    + Array to CSV exporting
    + Enhanced CAPTCHA
* User authentication with registration, forgot password and profile editor
* Contact Us page
* Basic admin tool with dashboard, user management, settings and Contact Us message list
* File-based sessions

That should be the absolute minimal things you need to get started on many projects. While there are many great CodeIgniter
CMS applications (see below), sometimes you don't need a full CMS, or you need something much simpler than what's available, 
or you need a completely customizable solution. That's why I created CI3 Fire Starter. I was tired of always having to do 
the same things over and over again. So I took some best practices, included all the addons and functions I most commonly use, and this was the end result, which I now use to start all of my projects.

I hope you find it useful. **Please [fork it on Github](https://github.com/JasonBaier/ci3-fire-starter/fork "Fork It") and help make it better!**

NOTE: This documentation assumes you are already familiar with PHP and CodeIgniter. If you need to learn more about
CodeIgniter, visit the user guide at http://www.codeigniter.com/userguide3/index.html. To learn more about PHP, visit
http://php.net/.

![Welcome Screen](http://s3.postimg.org/7vxaw3b2b/ci3_fire_starter_welcome_screen.png?raw=true)

##MODULAR

The former versions of CI Fire Starter (less than v3.0.0) used to implement wiredesign's Modular Extensions
(https://bitbucket.org/wiredesignz/codeigniter-modular-extensions-hmvc). At this time I have opted not to include it, however, if you have an argument in support of reimplementing it, I'm all ears... just let me know.

##BASE CLASSES

Phil Sturgeon wrote a very helpful blog post years ago called "CodeIgniter Base Classes: Keeping it DRY"
(http://philsturgeon.co.uk/blog/2010/02/CodeIgniter-Base-Classes-Keeping-it-DRY). The methods he described have been
applied to CI3 Fire Starter. There is a file in /application/core called MY_Controller.php which includes the Public,
Private, Admin and API base classes. This allows you to use shared functionality.

####MY_Controller

This loads settings, defines includes that get passed to the views, loads logged-in user data, sets the configured timezone,
and turns the profiler on or off. 

####Understanding Includes

* page_title    : the title of the page which gets inserted into the document head
* css_files     : an array of css files to insert into the document head
* js_files      : an array of javascript libraries to insert into the document body
* js_files_i18n : an array of javascript files with internationalization to insert into the document body (see more about these below)

Includes can be appended and/or overwritten from any controller function.

####Public_Controller

This extends MY_Controller and drives all your public pages (home page, etc). Any controller that extends
Public_Controller will be open for the whole world to see.

####Private_Controller

This extends MY_Controller and drives all your private pages (user profile, etc). Any controller that extends
Private_Controller will require authentication. Specific page requests are stored in session and will redirect upon
successful authentication.

![Profile Screen](http://s8.postimg.org/xpcn4kuud/ci3_fire_starter_profile_screen.png?raw=true)

####Admin_Controller

This extends MY_Controller and drives all your administration pages. Any controller that extends Admin_Controller will
require authentication from a user with administration privileges. Specific page requests are stored in session and will
redirect upon successful authentication.

![Settings Screen](http://s4.postimg.org/3ltmgpt5p/ci3_fire_starter_setttings_screen.png?raw=true)

####API_Controller

This extends MY_Controller and drives all your API functions. Any controller that extends API_Controller will be open
for the whole world to see (see below for details).

##CORE FILES

####Core Config

In application/config there is a file core.php. This file allows you to set site-wide variables. It is set up with site
name, site version, default templates, pagination settings, enable/disable the profiler and default form validation error delimiters.

####Core Language

In application/language/english is a file core_lang.php. This file allows you to set language variables that could be
used throughout the entire site (such as the words Home or Logout).

####Core Helper

In application/helper is a file core_helper.php. This includes the following useful functions:
* display_json($array) - used to output an array as JSON in a human-readable format - used by the API
* json_indent($array) - this is the function that actually creates the human-readable JSON string
* array_to_csv($array, $filename) - exports an array into a CSV file (see admin user list)

##LIBRARIES

####Jsi18n

In application/libraries is a file Jsi18n.php. This clever library allows you to internationalize your JavaScript files
through CI language files and was inspired by Alexandros D on coderwall.com (https://coderwall.com/p/j88iog).

Load this library in the autoload.php file or manually in your controller:

    $this->load->library('jsi18n');

In your language file:

    $lang['alert_message'] = "This is my alert message!";

In your JS files, place your language key inside double braces:

    function myFunction() {
        alert("{{alert_message}}");
    }

Render the Javascript file in your template file:

    <script type="text/javascript"><?php echo $this->jsi18n->translate("/themes/admin/js/my_javascript_i18n.js"); ?></script>

OR in your includes array:

    $this->includes = array_merge_recursive($this->includes, array(
        'js_files_i18n' => array(
            $this->jsi18n->translate("/themes/admin/js/my_javascript_i18n.js")
        )
    ));
    
##USER MANAGEMENT

CI3 Fire Starter comes with a simple user management tool in the administration tool. It uses a database table called
'users'. This tool demonstrates a lot of basic but important functionality:

* Sortable list columns
* Search filters
* Pagination with user-changeable items/page
* Exporting lists to CSV
* Form validation
* Harnessing the power of Bootstrap to accelerate development

![User Administration](http://s27.postimg.org/udwfwrtqb/ci3_fire_starter_user_list.png?raw=true)

Important note: user 1 is the main administrator - DO NOT MANUALLY DELETE. You can not delete this user from within the
admin tool.

##THEMES

There are 2 responsive themes provided with CI3 Fire Starter: 'admin' and 'default'. There is also a 'core' theme for global assets. To keep the application light-weight, I did not include a templating library, such as Smarty, nor did I utilize CI's 
built-in parser. If you really wanted to include one, you could check out Phil Sturgeon's CI-Dwoo extension 
(https://github.com/philsturgeon/codeigniter-dwoo).

####Theme Functions

***add_css_theme( $css_files )***

This function is used to easily add css files to be included in a template. With this function, you can just add the css file name as a parameter and it will use the default css path for the active theme.
You can add one or more css files as the parameter, either as a string or an array. If using parameter as a string, it must use comma separation between each css file name.

**Example:**

	 1. Using string as parameter
	     $this->add_css_theme("bootstrap.min.css, style.css, admin.css");
	 
	 2. Using array as parameter
	     $this->add_css_theme(array("bootstrap.min.css", "style.css", "admin.css"));

***add_js_theme($js_files, $is_i18n)***

This function is used to easily add Javascript files to be included in a template. With this function, you can just add the js file name as a parameter and it will use the default js path for the active theme.
You can add one or more js files as the parameter, either as a string or an array. If using the parameter as a string, it must use comma separation between each js file name.

The second parameter is used to indicate that the js file supports internationalization using the i18n library. Default is FALSE.

**Example:**

	 1. Using string as parameter
	     $this->add_js_theme("jquery-1.11.1.min.js, bootstrap.min.js, another.js");
	 
	 2. Using array as parameter
	     $this->add_js_theme(array("jquery-1.11.1.min.js", "bootstrap.min.js,", "another.js"));


***add_jsi18n_theme($js_files)***

This function is used to easily add Javascript files that support internationalization to be included in a template. With this function, you can just add the js file name as the parameter and it will use the default js path for the active theme.
You also can add one or more js files as the parameter, either as a string or an array. If using the parameter as a string, it must use comma separation between each js file name.

    1. Using string as parameter
	    $this->add_jsi18n_theme("dahboard_i18n.js, contact_i18n.js");
	
	2. Using array as parameter
	    $this->add_jsi18n_theme(array("dahboard_i18n.js", "contact_i18n.js"));
	
	3. Or we can use add_js_theme function, and add TRUE for second parameter
	    $this->add_js_theme("dahboard_i18n.js, contact_i18n.js", TRUE);
	    	- or -
	    $this->add_js_theme(array("dahboard_i18n.js", "contact_i18n.js"), TRUE);

***add_external_css( $css_files, $path )***

This function is used to easily add css files from external sources or outside the theme folder to be included in a template. 
With this function, you can just add the css file name and their external path as the parameter, or add css complete with path. See example below:

    1. Using string as first parameter
	    $this->add_external_css("global.css, color.css", "http://example.com/assets/css/");
	 	- or -
	    $this->add_external_css("http://example.com/assets/css/global.css, http://example.com/assets/css/color.css");
	
	2. Using array as first parameter
	    $this->add_external_css(array("global.css", "color.css"), "http://example.com/assets/css/");
		- or -
	    $this->add_external_css(array("http://example.com/assets/css/global.css", "http://example.com/assets/css/color.css"));

***add_external_js( $js_files, $path )***

This function is used to easily add js files from external sources or outside the theme folder to be included in a template. 
With this function, you can just add the js file name and their external path as the parameter, or add js complete with path. See example below:

    1. Using string as first parameter
	    $this->add_external_js("global.js, color.js", "http://example.com/assets/js/");
	 	- or -
	    $this->add_external_js("http://example.com/assets/js/global.js, http://example.com/assets/js/color.js");
	
	2. Using array as first parameter
	    $this->add_external_js(array("global.js", "color.js"), "http://example.com/assets/js/");
		- or -
	    $this->add_external_js(array("http://example.com/assets/js/global.js", "http://example.com/assets/js/color.js"));
		
These methods can also be chained like this:

    $this
        ->add_css_theme("bootstrap.min.css, style.css, admin.css")
		->add_external_css("global.css, color.css", "http://example.com/assets/css/")
        ->add_js_theme("jquery-1.11.1.min.js, bootstrap.min.js, another.js")
		->add_js_theme("dahboard_i18n.js, contact_i18n.js", TRUE)
		->add_external_js("global.js, color.js", "http://example.com/assets/js/");

Sometimes you might want to use a different template for different pages, for example, 404 template, login template, full-width template, sidebar template, etc.
You can simply load a different template using this function:

***set_template($template_file)***

##APIS

With the API class, you can quite easily create API functions for external applications. There is no security on these,
so if you need a more robust solution, such as authentication and API keys, check out Phil Sturgeon's CI Rest Server
(https://github.com/philsturgeon/codeigniter-restserver). You could also just set your own request authentication headers to the code that's already there.

![Sample JSON String](http://s8.postimg.org/nx4x1tdlx/ci3_fire_starter_sample_api.png?raw=true)

##SYSTEM REQUIREMENTS

* PHP version 5.4+
* MySQL 5.1+
* PHP GD extension for CAPTCHA to work
* PHP Mcrypt extension if you want to use the Encryption class

##INSTALLATION

* Create a new database and import the included sql file from the /assets folder
    + default administrator username/password is admin/admin
* Modify the application/config/config.php
    + line 215: set your log threshold - I usually set it to 1 for production environments
    + line 309: set your encryption key
* Modify the application/config/core.php
    + set your site name
* Modify application/config/database.php and connect to your database
* Upload all files to your server
* Make sure the /captcha/ folder has write permission
* Set /application/sessions permission to 0600
* Configure your path to use /htdocs
* Visit your new URL
* The default welcome page includes links to the admin tool and the private user profile page
* Make sure you log in to admin and change the administrator password!

##CONCLUSION

As I said earlier, CI3 Fire Starter does not attempt to be a full-blown CMS. You'd have
to build that functionality on your own. If you want a great CMS built on CodeIgniter, or need a more robust 
starting point, check out one of these awesome applications:

* HeroFramework: sadly, this project appears to no longer be active since their website went down - but the source is still available here: https://github.com/electricfunction/hero
* Halogy: http://www.halogy.com/
* Expression Engine: http://ellislab.com/expressionengine (from the original creators of CodeIgniter)
* GoCart: http://gocartdv.com/ (shopping cart)
* Open-Blog: http://www.open-blog.org/ (this is my other project - currently working on a complete rewrite, but it's
  been slow going)
* Bonfire: http://cibonfire.com/ (this is more of an application builder than a full CMS)
* FuelCMS: http://getfuelcms.com/
* CMS Canvas: http://www.cmscanvas.com/

#osx-docker-lamp, a.k.a dgraziotin/lamp

    Out-of-the-box LAMP+phpMyAdmin Docker image that *just works* on Mac OS X. 
    Including write support for mounted volumes (Website, MySQL).
    No matter if using the official boot2docker or having Vagrant in the stack, as well.

osx-docker-lamp, which is known as 
[dgraziotin/lamp](https://registry.hub.docker.com/u/dgraziotin/lamp/) 
in the Docker Hub, is a fork of 
[tutumcloud/tutum-docker-lamp](https://github.com/tutumcloud/tutum-docker-lamp), 
which is an "Out-of-the-box LAMP image (PHP+MySQL) for Docker". 

osx-docker-lamp does what tutumcloud/tutum-docker-lamp, plus:

- It is based on [phusion/baseimage:latest](http://phusion.github.io/baseimage-docker/)
  instead of ubuntu:trusty.
- It works flawlessy regardless of using boot2docker standalone or with Vagrant. You will need to set three enrironment varibles, though.
- It fixes OS X related [write permission errors for Apache](https://github.com/boot2docker/boot2docker/issues/581)
- It lets you mount OS X folders *with write support* as volumes for
  - The website
  - The database
- If `CREATE_MYSQL_BASIC_USER_AND_DB="true"`, it creates a default database and user with permissions to that database
- It provides phpMyAdmin at /phpmyadmin
- It is documented for less advanced users (like me)


##Usage

    If using Vagrant, please see the extra steps in the next subsection.

If you need to create a custom image `youruser/lamp`, 
execute the following command from the `osx-docker-lamp` source folder:

	docker build -t youruser/lamp .

If you wish, you can push your new image to the registry:

	docker push youruser/lamp

Otherwise, you are free to use dgraziotin/lamp as it is provided. Remember first
to pull it from the Docker Hub:

    docker pull dgraziotin/lamp

###Vagrant

If, for any reason, you would rather use Vagrant (I suggest using [AntonioMeireles/boot2docker-vagrant-box](https://github.com/AntonioMeireles/boot2docker-vagrant-box)), you need to add the following three variables when running your box:

-`VAGRANT_OSX_MODE="true"` for enabling Vagrant-compatibility
-`DOCKER_USER_ID=$(id -u)` for letting Vagrant use your host user ID for mounted folders
-`DOCKER_USER_GID=$(id -g)` for letting Vagrant use your host user GID for mounted folders

See the Environment variables section for more options.

###Running your LAMP docker image

If you start the image without supplying your code, e.g.,

	docker run -t -i -p 80:80 -p 3306:3306 --name osxlamp dgraziotin/lamp

At http://[boot2docker ip, e.g., 192.168.59.103] you should see an 
"Hello world!" page.

At http://[boot2docker ip]/phpmyadmin you should see a running phpMyAdmin instance.


###Loading your custom PHP application

In order to replace the _Hello World_ application that comes bundled with this 
docker image, my suggested layout is the following:

- _Project name_ folder
  - app subfolder
  - mysql subfolder (optional)

The app folder should contain the root of your PHP application.

Run the following code from within the _Project name_ folder.

	docker run -i -t -p "80:80" -p "3306:3306" -v ${PWD}/app:/app --name yourwebapp dgraziotin/lamp

Test your deployment:

	http://[boot2docker ip]
	http://[boot2docker ip]/phpmyadmin

If you wish to mount a MySQL folder locally, so that MySQL files are saved on your
OS X machine, run the following instead:

	docker run -i -t -p "80:80" -p "3306:3306" -v ${PWD}/mysql:/var/lib/mysql -v ${PWD}/app:/app --name yourwebapp dgraziotin/lamp

The MySQL database will thus become persistent at each subsequent run of your image.

##Environment description


###The /app folder

Apache is configured to serve the files from the `/app` folder, which is a symbolic
link to `/var/www/html`. In osx-docker-lamp, the apache user `www-data` 
has full write permissions to the `app` folder.

###Apache

Apache is pretty much standard in this image. It is configured to serve the Web app
at `app` as `/` and phpMyAdmin as `/phpmyadmin`. Mod rewrite is enabled.

Apache runs as user www-data and group staff. The write support works because the
user www-data is configured to have the same user id as the one employed by boot2docker (1000).

###phpMyAdmin

The latest version of phpMyAdmin is grabbed from sourceforge and installed in
the folder `/var/www/phpmyadmin`. 

PhpMyAdmin can be reached from 
http://[boot2docker ip]/phpmyadmin. Only the users `admin` and `user` can access
phpMyAdmin.

At your convenience, a not-so-random blowfish_secret is stored in phpMyAdmin 
configuration, which is at `/var/www/phpmyadmin/config.inc.php`

###MySQL

MySQL runs as user www-data, as well. This is not the best settings for production.
However, this is needed for proving write support to mounted volumes under Mac OS X.

####The three MySQL users

The bundled MySQL server has two users, that are `root` and `admin`, and an optional
third user `user`.

The `root` account comes with an empty password, and it is for local connections
(e.g., using some code). The `root` user cannot remotely access the database 
(and the container).

However, the first time that you run your container, a new user `admin` 
with all root privileges  will be created in MySQL with a random password. 

To get the password, check the logs of the container by running:

	docker logs [name or id, e.g., mywebsite]

You will see an output like the following:

	========================================================================
	You can now connect to this MySQL Server using:

	    mysql -uadmin -p47nnf4FweaKu -h<host> -P<port>

	Please remember to change the above password as soon as possible!
	MySQL user 'root' has no password but only allows local connections
	========================================================================

In this case, `47nnf4FweaKu` is the password allocated to the `admin` user.

Finally, an optional a user called `user` with password `password` can be created for your convenience either when:
 - The environment variable `CREATE_MYSQL_BASIC_USER_AND_DB` is true; or
 - Any of the `MYSQL_USER_*` variable (explained below) is true
The user is called `user` and has as password `password`.

The `user` user has full privileges on a database called `db`, which is also created
for your convenience. As with the `admin` user, the user `user` can access
the MySQL server from any host (`%`).
The user name, password, and database name can be changed using
the the `MYSQL_USER_*` variables, explained below.

##Environment variables

- `MYSQL_ADMIN_PASS="mypass"` will use your given MySQL password for the `admin`
user instead of the random one.
- `CREATE_MYSQL_BASIC_USER_AND_DB="true"` will create the user `user` with db `db` and password `password`. Not needed if using one of the following three `MYSQL_USER_*` variables
- `MYSQL_USER_NAME="daniel"` will use your given MySQL username instead of `user`
- `MYSQL_USER_DB="supercooldb"` will use your given database name instead of `db`
- `MYSQL_USER_PASS="supersecretpassword"` will use your given password  instead of `password`
- `PHP_UPLOAD_MAX_FILESIZE="10M"` will change PHP upload_max_filesize config value
- `PHP_POST_MAX_SIZE="10M"` will change PHP post_max_size config value
-`VAGRANT_OSX_MODE="true"` for enabling Vagrant-compatibility
-`DOCKER_USER_ID=$(id -u)` for letting Vagrant use your host user ID for mounted folders
-`DOCKER_USER_GID=$(id -g)` for letting Vagrant use your host user GID for mounted folders

Set these variables using the `-e` flag when invoking the `docker` client.

	docker run -i -t -p "80:80" -p "3306:3306" -v ${PWD}/app:/app -e MYSQL_ADMIN_PASS="mypass" --name yourwebapp dgraziotin/lamp

Please note that the MySQL variables will not work if an existing MySQL volume is supplied.
