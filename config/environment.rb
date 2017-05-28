require 'bundler'
require 'json'
require 'pi_piper'

Bundler.require

# set the pathname for the root of the app
require 'pathname'
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

# require the controller(s)
Dir[APP_ROOT.join('controllers', '*.rb')]
  .each { |file| require file }

# configure Server settings
module SinIo
  json_config = File.read(APP_ROOT.join('config', 'gpio_config.json'))
  parsed_config = JSON.parse(json_config)

  ## global pin state
  Directions = Hash[parsed_config['directions']
    .map { |k, _v| k.to_i }
    .zip(parsed_config['directions'].values)
  ]

  AppPins = Hash[parsed_config['pins']
    .map { |k, _v| k.to_i }
    .zip(parsed_config['pins'].values)
  ]

  RPI = parsed_config['rpi']
  @gpio_pins = {}

  # if RPI is given to be true the GPIO code will run
  if RPI
    puts 'CONNECTING TO GPIO PINS'
    AppPins.each do |pin, _v|
      @gpio_pins[pin] = PiPiper::Pin.new(
        pin: pin,
        direction: Directions[pin].to_sym
      )
    end

    AppPins.each do |pin, state|
      state ? @gpio_pins[pin].on : @gpio_pins[pin].off
    end
    puts 'CONNECTED - SERVER IS RUNNING'
  end

  class Server < Sinatra::Base
    set :method_override, true
    set :root, APP_ROOT.to_path
  end
end
