require "por_manager"

namespace :db do
  desc "Load airports database from opentraveldata"
  task :load_airports => ['db:load_countries', 'db:load_cities'] do

    unless PorManager.update_optd_por_csv()
      raise RuntimeError, "Unable to download airports data"
    end
    
    PorManager.update_airports()
    
    puts "Airports: #{TiRefdata::Airport.all.map(&:code).join(',')}"
  end
end
