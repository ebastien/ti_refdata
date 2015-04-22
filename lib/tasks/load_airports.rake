require 'ti_refdata/por_manager'

namespace :db do
  desc "Load airports database from opentraveldata"
  task :load_airports, [:http_proxy] => ['db:load_countries', 'db:load_cities'] do |t, args|

    unless TiRefdata::PorManager.update_optd_por_csv(args[:http_proxy])
      raise RuntimeError, "Unable to download airports data"
    end
    
    TiRefdata::PorManager.update_airports()
    
    puts "Airports: #{TiRefdata::Airport.all.map(&:code).join(',')}"
  end
end
