module SpecRoutes
  def self.included(base)
    base.routes { TiRefdata::Engine.routes }
  end 
end

RSpec.configure do |config|
  config.include SpecRoutes, type: :routing
  config.include SpecRoutes, type: :controller
end
