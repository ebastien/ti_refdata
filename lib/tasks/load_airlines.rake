require 'ti_refdata/por_manager'

namespace :db do
  desc "Load airlines database from opentraveldata"
  task :load_airlines, [:http_proxy] => :environment do |t, args|
    args.with_defaults(:http_proxy => '')
    unless TiRefdata::PorManager.update_optd_airlines_csv(args[:http_proxy])
      raise RuntimeError, "Unable to download airlines data"
    end
    
    TiRefdata::PorManager.update_airlines()
    
    puts "Airlines: #{TiRefdata::Airline.all.map(&:unified_code).join(',')}"
  end
end
