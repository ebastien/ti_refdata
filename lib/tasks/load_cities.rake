require 'ti_refdata/por_manager'

namespace :db do
  desc "Load cities database from opentraveldata"
  task :load_cities, [:http_proxy] => 'db:load_countries' do |t, args|
    args.with_defaults(:http_proxy => '')
    unless TiRefdata::PorManager.update_optd_por_csv(args[:http_proxy])
      raise RuntimeError, "Unable to download cities data"
    end
    
    TiRefdata::PorManager.update_cities()
    
    puts "Cities: #{TiRefdata::City.all.map(&:code).join(',')}"
  end
end
