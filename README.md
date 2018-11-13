# PNG Image Generator Skeleton Application

Web application skeleton using Fano, Pascal web application framework.
This web application generates PNG image on the fly. The image resolution
is defined by user in Url. For example

```
http://[your app hostname]/image/{width}x{height}.png
```
Where `{width}` and `{height}` is integer value between 10 to 300.

## Requirement

- [Free Pascal](https://www.freepascal.org/) >= 3.0
- Web Server (Apache, nginx)
- [Fano Web Framework](https://github.com/fanoframework/fano)

## Installation

### Build

Make sure [Free Pascal](https://www.freepascal.org/) is installed. Run

    $ fpc -i

If you see something like `Free Pascal Compiler version 3.0.4`,  you are good to go.

Clone this repository

    $ git clone git@github.com:fanoframework/fano-app-img.git --recursive

`--recursive` is needed so git also pull [Fano](https://github.com/fanoframework/fano) repository.

If you are missing `--recursive` when you clone, you may find that `fano` directory is empty. In this case run

    $ git submodule update --init

To update Fano to its latest commit, run

    $ git checkout master && git submodule foreach --recursive git pull origin master

Above command will checkout to `master` branch of this repository and pull latest update from `master` branch of [Fano](https://github.com/fanoframework/fano) repository.

Copy `*.cfg.sample` to `*.cfg`.
Make adjustment as you need in `build.cfg`, `build.prod.cfg`, `build.dev.cfg`
and run `build.sh` shell script (if you are on Windows, then `build.cmd`).

These `*.cfg` files contain some Free Pascal compiler switches that you can turn on/off to change how executable is compiled and generated. For complete
explanation on available compiler switches, consult Free Pascal documentation.


    $ cp build.prod.cfg.sample build.prod.cfg
    $ cp build.dev.cfg.sample build.dev.cfg
    $ cp build.cfg.sample build.cfg
    $ ./build.sh

`tools/config.setup.sh` shell script is provided to simplify copying those
configuration files. Following shell command is similar to command above.

    $ ./tools/config.setup.sh
    $ ./build.sh

By default, it will output binary executable in `app/public` directory.

### Build for different environment

To build for different environment, set `BUILD_TYPE` environment variable.

#### Build for production environment

    $ BUILD_TYPE=prod ./build.sh

Build process will use compiler configuration defined in `fano/fano.cfg`, `build.cfg` and `build.prod.cfg`. By default, `build.prod.cfg` contains some compiler switches that will aggressively optimize executable both in speed and size.

#### Build for development environment

    $ BUILD_TYPE=dev ./build.sh

Build process will use compiler configuration defined in `fano/fano.cfg`, `build.cfg` and `build.dev.cfg`.

If `BUILD_TYPE` environment variable is not set, production environment will be assumed.

## Change executable output directory

Compilation will output executable to directory defined in `EXEC_OUTPUT_DIR`
environment variable. By default is `app/public` directory.

    $ EXEC_OUTPUT_DIR=/path/to/public/dir ./build.sh

## Change executable name

Compilation will use executable filename as defined in `EXEC_OUTPUT_NAME`
environment variable. By default is `app.cgi` filename.

    $ EXEC_OUTPUT_NAME=index.cgi ./build.sh

## Run

### Run with a webserver

Setup a virtual host. Please consult documentation of web server you use.

For example on Apache,

```
<VirtualHost *:80>
     ServerName www.example.com
     DocumentRoot /home/example/app/public

     <Directory "/home/example/app/public">
         Options +ExecCGI
         AllowOverride FileInfo
         Require all granted
         DirectoryIndex app.cgi
         AddHandler cgi-script .cgi
     </Directory>
</VirtualHost>
```
On Apache, you will need to enable CGI module, such as `mod_cgi` or `mod_cgid`. If CGI module not loaded, above virtual host will cause `app.cgi` is downloaded instead of executed.

For example, on Debian, this will enable `mod_cgi` module.

```
$ sudo a2enmod cgi
$ sudo systemctl restart apache2
```

Depending on your server setup, for example, if  you use `.htaccess`, add following code:

```
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^(.*)$ app.cgi [L]
</IfModule>
```
and put `.htaccess` file in same directory as `app.cgi` file (i.e., in `app/public` directory).

Content of `.htaccess` basically tells Apache to serve existing files/directories directly. For any non-existing files/directories, pass them to our application.

If successful, when you visit application URL, for example

    http://[your_app_name]/image/100x100.png
    http://[your_app_name]/image/200x200.png

You will get PNG image displayed.

### Simulate run on command line

```
$ cd app/public
$ REQUEST_METHOD=GET \
  REQUEST_URI=/test/test \
  SERVER_NAME=juhara.com \
  ./app.cgi
```

`tools/simulate.run.sh` is bash script that can be used to simplify simulating run
application in shell.

    $ ./tools/simulate.run.sh

or to change route to access, set `REQUEST_URI` variable.

    $ REQUEST_URI=/test/test ./simulate.run.sh

This is similar to simulating browser requesting this page,for example,

    $ wget -O- http://[your fano app hostname]/test/test

However, running using `tools/simulate.run.sh` allows you to view output of `heaptrc`
unit for detecting memory leak (if you enable `-gh` switch in `build.dev.cfg`).


## Deployment

You need to deploy only executable binary. Any `pas` or `inc` files or shell scripts is not needed in deployment machine in order application to run.

## Known Issues

### Issue with GNU Linker

When running `build.sh` script, you may encounter following warning:

```
/usr/bin/ld: warning: app/public/link.res contains output sections; did you forget -T?
```

This is known issue between FreePascal and GNU Linker. See
[FAQ: link.res syntax error, or "did you forget -T?"](https://www.freepascal.org/faq.var#unix-ld219)

However, this warning is minor and can be ignored. It does not affect output executable.

### Issue with unsynchronized compiled unit with unit source

Sometime FreePascal can not compile your code because, for example, you deleted a
unit source code (.pas) but old generated unit (.ppu, .o, .a files) still there
or when you switch between git branches. Solution is to remove those files.

By default, generated compiled units are in `bin/unit` directory.
But do not delete `README.md` file inside this directory, as it is not being ignored by git.

```
$ rm bin/unit/*.ppu
$ rm bin/unit/*.o
$ rm bin/unit/*.rsj
$ rm bin/unit/*.a
```

Following shell command will remove all files inside `bin/unit` directory except
`README.md` file.

    $ find bin/unit ! -name 'README.md' -type f -exec rm -f {} +

`tools/clean.sh` script is provided to simplify this task.

### Windows user

Free Pascal supports Windows as target operating system, however, this repository is not yet tested on Windows. To target Windows, in `build.cfg` replace
compiler switch `-Tlinux` with `-Twin64` and uncomment line `#-WC` to
become `-WC`.

### Lazarus user

While you can use Lazarus IDE, it is not mandatory tool. Any text editor for code editing (Atom, Visual Studio Code, Sublime, Vim etc) should suffice.
