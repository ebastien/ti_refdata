require "por_manager"

namespace :db do
  desc "Load airlines database from opentraveldata"
  task :load_airlines => :environment do
    unless TiRefdata::PorManager.update_optd_airlines_csv()
      raise RuntimeError, "Unable to download airlines data"
    end
    
    TiRefdata::PorManager.update_airlines()
    
    puts "Airlines: #{TiRefdata::Airline.all.map(&:unified_code).join(',')}"
  end
end
