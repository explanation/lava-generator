require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsTypescriptgen
    class Application < Rails::Application
        # Initialize configuration defaults for originally generated Rails version.
        config.load_defaults 7.0

        # Configuration for the application, engines, and railties goes here.
        #
        # These settings can be overridden in specific environments using the files
        # in config/environments, which are processed later.
        #
        # config.time_zone = "Central Time (US & Canada)"
        # config.eager_load_paths << Rails.root.join("extras")

        # Only loads a smaller set of middleware suitable for API only apps.
        # Middleware like session, flash, cookies can be added back manually.
        # Skip views, helpers and assets when generating a new resource.
        config.api_only = true
        config.generators do |g|
            g.orm :active_record
            g.template_engine :erb
            g.test_framework :test_unit, fixture: false
            g.orm :active_record, primary_key_type: :uuid
            g.orm :active_record, migration: false
            g.orm :active_record, timestamps: true
            g.model_name "models/model"
            g.fallbacks[:active_record] = :active_record
        end
    end
end
