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
  ## global pin state
  AppPins = {17 => false}
  GpioPins = {}

  # if a RPI ENV VAR is given to be true this code will run
  if ENV["RPI"] == ["true"]
    AppPins.each do |pin, v|
      GpioPins[pin] = PiPiper::Pin.new(pin: pin, direction: :out)
    end
  end

  class Server < Sinatra::Base
    set :method_override, true
    set :root, APP_ROOT.to_path
  end
end
