# require your gems
require "bundler"
require "json"
require "pi_piper"

Bundler.require

# set the pathname for the root of the app
require "pathname"
APP_ROOT = Pathname.new(File.expand_path("../../", __FILE__))

# require the model(s)
Dir[APP_ROOT.join("models", "*.rb")]
  .each { |file| require file }

# require the controller(s)
Dir[APP_ROOT.join("controllers", "*.rb")]
  .each { |file| require file }

# configure Server settings
module SinIo
  AppPins = {17 => false}
  GpioPins = {}

  # AppPins.each do |pin, v|
  #   GpioPins[pin] = PiPiper::Pin.new(pin: pin, direction: :out)
  # end

  class Server < Sinatra::Base
    set :method_override, true
    set :root, APP_ROOT.to_path
    set :views, File.join(SinIo::Server.root, "views")
    set :public_folder, File.join(SinIo::Server.root, "public")
  end
end