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
  Directions = Hash[
    parsed_config["directions"]
      .map { |k, v| k.to_i }
      .zip(parsed_config["directions"].values)
    ]

  AppPins = Hash[
    parsed_config["pins"]
      .map { |k, v| k.to_i }
      .zip(parsed_config["pins"].values)
    ]

  RPI = parsed_config["rpi"]
  GpioPins = {}

  # if RPI is given to be true the GPIO code will run
  if RPI
    puts "CONNECTING TO GPIO PINS"
    AppPins.each do |pin, v|
      GpioPins[pin] = PiPiper::Pin.new(
        pin: pin,
        direction: Directions[pin].to_sym
       )
    end

    AppPins.each do |pin, state|
      state ? GpioPins[pin].on : GpioPins[pin].off
    end
    puts "CONNECTED"
  end

  class Server < Sinatra::Base
    set :method_override, true
    set :root, APP_ROOT.to_path
  end
end
