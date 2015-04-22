require "por_manager"

namespace :db do
  desc "Load cities database from opentraveldata"
  task :load_cities => 'db:load_countries' do
    unless PorManager.update_optd_por_csv()
      raise RuntimeError, "Unable to download cities data"
    end
    
    PorManager.update_cities()
    
    puts "Cities: #{TiRefdata::City.all.map(&:code).join(',')}"
  end
end
