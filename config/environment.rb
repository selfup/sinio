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

  APP_PINS = Hash[parsed_config['pins']
    .map { |k, _v| k.to_i }
    .zip(parsed_config['pins'].values)
  ]

  # ENV vars cannot be passed through rbenv sudo
  # they can be via rvmsudo but this is to differentiate
  # between RPI or non RPI machine
  RPI = ENV['RPI'].is_a?(String) ? false : parsed_config['rpi']
  GPIO_PINS = {}

  # if RPI is given to be true the GPIO code will run
  if RPI
    puts 'CONNECTING TO GPIO PINS'
    APP_PINS.each do |pin, _v|
      GPIO_PINS[pin] = PiPiper::Pin.new(
        pin: pin,
        direction: Directions[pin].to_sym
      )
    end

    APP_PINS.each do |pin, state|
      state ? GPIO_PINS[pin].on : GPIO_PINS[pin].off
    end
    puts 'CONNECTED - SERVER IS RUNNING'
  end

  class Server < Sinatra::Base
    set :method_override, true
    set :root, APP_ROOT.to_path
  end
end
