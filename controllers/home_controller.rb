module SinIo
  class Server < Sinatra::Base
    get '/pins' do
      content_type :json
      APP_PINS.to_json
    end

    ## not RESTful but makes life easy :)
    get '/set' do
      bool_key = {
        'true' => true,
        true => true,
        'false' => false,
        false => false
      }

      request.params.each do |k, v|
        value = bool_key[v]
        if value
          RPI ? GPIO_PINS[k.to_i].on : nil
        else
          RPI ? GPIO_PINS[k.to_i].off : nil
        end
        APP_PINS[k] = value
      end
      content_type :json
      APP_PINS.to_json
    end
  end
end
