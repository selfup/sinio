# require your gems
require "bundler"
require "json"
require "pi_piper"

Bundler.require

# set the pathname for the root of the app
require "pathname"
APP_ROOT = Pathname.new(File.expand_path("../../", __FILE__))

# require the controller(s)
Dir[APP_ROOT.join("controllers", "*.rb")]
  .each { |file| require file }

# configure Server settings
module SinIo
  json_config = File.read(APP_ROOT.join("config", "gpio_config.json"))
  parsed_config = JSON.parse(json_config)

  ## global pin state
  Directions = parsed_config["directions"]
  AppPins = parsed_config["pins"]
  GpioPins = {}

  # if a RPI ENV VAR is given to be true this code will run
  if ENV["RPI"] == ["true"]
    AppPins.each do |pin, v|
      GpioPins[pin] = PiPiper::Pin.new(
        pin: pin,
        direction: Directions[pin].to_sym
       )
    end

    AppPins.each do |pin, state|
      state ? GpioPins[pin].on : GpioPins[pin].off
    end
  end

  class Server < Sinatra::Base
    set :method_override, true
    set :root, APP_ROOT.to_path
  end
end
