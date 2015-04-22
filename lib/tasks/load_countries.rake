namespace :db do
  desc "Load countries database from opentraveldata"
  task :load_countries => :environment do
    unless PorManager.update_optd_countries_csv()
      raise RuntimeError, "Unable to download countries data"
    end
  
    PorManager.update_countries()
    
    puts "Countries: #{TiRefdata::Country.all.map(&:code).join(',')}"
  end
end


