# Sinatra GPIO API (sinio)

Must run on: Raspberry Pi 2 B or newer

Default is direction out on pin 17 only. You can mess around with the config :tada:

**To be used as an internal node. Another application on the RPI should talk to this :smile:**

### Requirements

An up to date raspberry pi. To be sure, run `sudo apt-get update -y`

*no guarantees! I made sure to use the least amount of deps other than ruby and rbenv/rvm sudo*

**ruby 2.3.0** *or greater* installed via `rbenv` or `rvm` on the raspberry pi

I use ruby 2.4.0, up to you!

**rbenv sudo** [rbenv sudo](https://github.com/dcarley/rbenv-sudo)

`rbenv sudo bundle exec rackup`

**rvmsudo** [rvmsudo](https://rvm.io/integration/sudo)

`rvmsudo bundle exec rackup`

### Scripts (rpi only)

There is a production script that will run the app on `localhost:9292`

Run it like so: `./scripts/production.sh`

It will *run the app as a daemon* and set the RPI=true ENV VAR for you

---------------------------------------------------------------------------------------------------

There is a dev script that will not run as a daemon

It will run on the same host/port as the above script

Run it like so: `./scripts/rpi_dev.sh`

---------------------------------------------------------------------------------------------------

*these scripts assume you are using `rbenv sudo` you may change them to use `rvmsudo` :rocket:*

### Options

* to set base ip: `bundle exec rackup --host 0.0.0.0`
* to set a port: `bundle exec rackup -p 8080`
* to run as daemon: `bundle exec rackup -D` (you can also use screen or tmux and detach instead of `-D`)

* to set all three (ip, port, daemon): `bundle exec rackup --host 0.0.0.0 -p 8080 -D`

*don't forget to use rbenv/rvm sudo!*

***

### Api

**GET (fetch pin state)**

GET -> `/pins`

***

**GET (update pin state)**

GET -> `/set?17=true`

*This will turn on GPIO 17*

GET -> `/set?17=false`

*This will turn off GPIO 17*
