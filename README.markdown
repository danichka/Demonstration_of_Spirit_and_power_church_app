[![Build Status](https://travis-ci.org/Loremaster/Demonstration_of_Spirit_and_power_church_app.svg)](https://travis-ci.org/Loremaster/Demonstration_of_Spirit_and_power_church_app)

This is source code of the web application for the church "Demonstration of Spirit and power".

#Setup
####Ruby version

This app uses ruby 2.1.5. There are 2 files in this project: `.ruby-gemset` and `.ruby-version` to tell RVM to use them by default.

####System dependencies

On Mac you can install dependencies using homebrew:

```
$ brew update
$ brew install postgresql
$ brew install memcached
```

####Configuration

1. Clone this repository.
2. Create file `database.yml` using `config/database.example.yml` as your example. Remove `production` section.
3. Create file `secrets.yml` using `config/secrets.example.yml` as your example.
4. Run `$ bundle`

####Database creation

```
$ rake db:create:all
$ rake db:migrate
$ rake db:test:prepare
```

####Database initialization

```
$ rake db:seeds
```

####How to run the test suite

If you have spring and generated bunstubs then:

```
$ spring stop
$ bin/rspec
```

####Services

Dalli is used as cache storage so you need memcache for that.

####Deployment instructions

*This section will be filled in the future...*
