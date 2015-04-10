class AirportNameAsciiToNormalized < ActiveRecord::Migration
  def up
    rename_column :airports, :name_ascii, :name_normalized
    TiRefdata::Airport.find_each do |airport|
      airport.name_normalized.gsub!(/[^a-z]/,' ')
      airport.name2_normalized.gsub!(/[^a-z]/,' ')
      airport.save
    end
  end

  def down
    rename_column :airports, :name_normalized, :name_ascii
  end
end
