$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ti_refdata/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ti_refdata"
  s.version     = TiRefdata::VERSION
  s.authors     = ["Emmanuel Bastien"]
  s.email       = ["os@ebastien.name"]
  s.homepage    = "https://github.com/opentraveldata"
  s.summary     = "Reference data server."
  s.description = "TiRefdata serves resources on open travel data."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.17"
  s.add_dependency "rails-api"
  s.add_dependency "active_model_serializers", "~> 0.7.0"
  s.add_dependency "ti_devise_auth"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rspec-collection_matchers"
  s.add_development_dependency "fabrication"
  s.add_development_dependency "jsonpath"
end
