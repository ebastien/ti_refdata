require 'active_model_serializers'

module TiRefdata
  def self.table_name_prefix
  end

  class Engine < ::Rails::Engine
    isolate_namespace TiRefdata

    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :fabrication
    end
  end
end
