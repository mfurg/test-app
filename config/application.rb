require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ArticlesAppWithApi
  class Application < Rails::Application
    config.load_defaults 7.0
    config.hosts.clear

    config.middleware.insert_before ActionDispatch::Static, Rack::Cors do
      allow do
        origins '*'

        resource '*', 
        headers: :any, 
        methods: :any, 
        expose: ["Authorization"]
      end
    end

    
    config.middleware.use ActionDispatch::Flash
    
  end
end
