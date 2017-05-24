include AssetBundleModule

module SinIo
  class Server < Sinatra::Base
    get "/" do
      erb :index, locals: {
				script: js_bundle,
        css: css_bundle,
        page_name: "home#index",
			}
    end

    get "/pins" do
      content_type :json
      # request.params["direction"]
      AppPins
        .map { |pin, value| "gpio: #{pin} - on? #{value}" }
        .to_json
    end
	end
end
