require 'ti_refdata/por_manager'

namespace :db do
  desc "Load countries database from opentraveldata"
  task :load_countries, [:http_proxy] => :environment do |t, args|
    args.with_defaults(:http_proxy => '')
    unless TiRefdata::PorManager.update_optd_countries_csv(args[:http_proxy])
      raise RuntimeError, "Unable to download countries data"
    end
  
    TiRefdata::PorManager.update_countries()
    
    puts "Countries: #{TiRefdata::Country.all.map(&:code).join(',')}"
  end
end


