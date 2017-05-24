require 'pry'

module SinIo
  class Server < Sinatra::Base
    get "/pins" do
      content_type :json
      AppPins.to_json
    end

    put "/pins" do
      cross_origin :allow_origin => 'http://example.com',
        :allow_methods => [:put]

      bool_key = {
        "true"=> true,
        true=> true,
        "false"=> false,
        false=> false,
      }

      request.params.each do |k, v|
        value = bool_key[v]
        if value
          GpioPins[k.to_i].on
          AppPins[k] = value
        else
          GpioPins[k.to_i].off
          AppPins[k] = value
        end
      end
      
      content_type :json
      AppPins.to_json
    end
	end
end
