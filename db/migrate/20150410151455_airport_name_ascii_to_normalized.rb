class AirportNameAsciiToNormalized < ActiveRecord::Migration
  def up
    rename_column :airports, :name_ascii, :name_normalized
    TiRefdata::Airport.find_each do |airport|
      airport.name_normalized = 
          airport.name_normalized.gsub(/[^a-z]/,' ') if airport.name_normalized
      airport.save
    end
  end

  def down
    rename_column :airports, :name_normalized, :name_ascii
  end
end
