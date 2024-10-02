module SpreeShipday
  class Engine < Rails::Engine
    require 'spree/core'
    require 'rake'
    isolate_namespace Spree
    engine_name 'spree_shipday'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    rake_tasks do
      load File.expand_path('../../../lib/tasks/shipday.rake', __FILE__)
    end

    initializer 'spree_shipday.environment', before: :load_config_initializers do |_app|
      SpreeShipday::Config = SpreeShipday::Configuration.new
    end

    initializer 'spree_shipday.create_shipping_method', after: :load_config_initializers do
      unless Rails.application.config.assets.precompile
        Rails.application.config.after_initialize do
          SpreeShipday::Engine.create_shipday_shipping_method
        end
      end
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
