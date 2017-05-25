# Sinatra GPIO API (sinio)

Must run on: Raspberry Pi 2 B or newer

Default is direction out on pin 17 only. You can mess around with the config :tada:

**To be used as an internal node. Another application on the RPI should talk to this :smile:**

### Fire up

**rbenv sudo** [rbenv sudo](https://github.com/dcarley/rbenv-sudo)

`rbenv sudo bundle exec rackup`

**rvmsudo** [rvmsudo](https://rvm.io/integration/sudo)

`rvmsudo bundle exec rackup`

### Options

* to set base ip: `bundle exec rackup --host 0.0.0.0`
* to set a port: `bundle exec rackup -p 8080`
* to run as daemon: `bundle exec rackup -D` (you can also use screen or tmux and detach)

to set all three (ip, port, daemon): `bundle exec rackup --host 0.0.0.0 -p 8080 -D`

**don't forget to use rbenv or rvm sudo!**

### Api

*GET (fetch pin state)*

If set on `0.0.0.0` and port `8080` and the raspberry pi is on `10.0.0.23` (for example)

GET -> 10.0.0.23:8080/pins

***

*PUT (update the pin/s)*

PUT -> ip:port/pins?17=true

This will turn on GPIO 17

PUT -> ip:port/pins?17=false

This will turn it off
