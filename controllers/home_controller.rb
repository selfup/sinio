require 'pry'

module SinIo
  class Server < Sinatra::Base
    get "/pins" do
      content_type :json
      AppPins.to_json
    end

    ## not RESTful but makes life easy :)
    get "/set" do
      bool_key = {
        "true" => true,
        true => true,
        "false" => false,
        false => false,
      }

      request.params.each do |k, v|
        value = bool_key[v]
        if value
          ENV["RPI"] == "true" ? GpioPins[k.to_i].on : nil
          AppPins[k] = value
        else
          ENV["RPI"] == "true" ? GpioPins[k.to_i].off : nil
          AppPins[k] = value
        end
      end
      
      content_type :json
      AppPins.to_json
    end
  end
end

