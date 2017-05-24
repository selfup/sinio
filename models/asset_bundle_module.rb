module AssetBundleModule
  def js_bundle
    if ENV['SINATRA_ENV'] == "production"
      "prod/bundle.js"
    else
      "http://localhost:8080/bundle.js"
    end
  end

  def css_bundle
    if ENV['SINATRA_ENV'] == "production"
      "prod/bundle.css"
    else
      "http://localhost:8080/bundle.css"
    end
  end
end
