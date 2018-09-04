# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module FExplorerRorOnly
  # Application
  class Application < Rails::Application
    config.load_defaults 5.2

    config.generators do |g|
      g.helper false
      g.javascripts false
      g.stylesheets false
      g.test_framework false
    end
  end
end
