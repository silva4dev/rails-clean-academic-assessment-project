require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    config.load_defaults 7.2
    config.autoload_paths += Dir[Rails.root.join("app", "layers")]
    config.autoload_lib(ignore: %w[assets tasks])
    config.api_only = true
  end
end
