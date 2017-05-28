# Sinatra GPIO API (sinio)

Must run on: Raspberry Pi 2 B or newer

Default is direction out on pin 17 only. You can mess around with the config :tada:

To be used as an internal node. Another application on the RPI should talk to this!

Have another app serve the api/webpage from the same raspberry pi and have it proxy via internal api calls.

*Because* we must use **sudo** to run this GPIO Server, it is best to have it as extracted as possible (micro/pico service).

### Requirements

**An up to date raspberry pi** To be sure, run `sudo apt-get update -y`

**ruby 2.3.0** *or greater* installed via `rbenv` or `rvm` on the raspberry pi

--

**rbenv sudo** [rbenv sudo](https://github.com/dcarley/rbenv-sudo)

OR

**rvmsudo** [rvmsudo](https://rvm.io/integration/sudo)

--

### Scripts (rpi only)

There is a production script that will run the app on `localhost:9292`

Run it like so: `./scripts/production.sh`

It will *run the app as a daemon* and set the RPI=true ENV VAR for you

--

There is a dev script that will not run as a daemon

It will run on the same host/port as the above script

Run it like so: `./scripts/rpi_dev.sh`

--

*these scripts assume you are using `rbenv sudo` you may change them to use `rvmsudo` :rocket:*

### Options

* to set base ip: `bundle exec rackup --host 0.0.0.0`
* to set a port: `bundle exec rackup -p 8080`
* to run as daemon: `bundle exec rackup -D` (you can also use screen or tmux and detach instead of `-D`)

* to set all three (ip, port, daemon): `bundle exec rackup --host 0.0.0.0 -p 8080 -D`

**don't forget to use rbenv/rvm sudo!** ex: `rbenv sudo bundle exec rackup`

### Api

**GET (fetch pin state)**

GET -> `/pins`

**GET (update pin state)**

GET -> `/set?17=true`

*This will turn on GPIO 17*

GET -> `/set?17=false`

*This will turn off GPIO 17*
