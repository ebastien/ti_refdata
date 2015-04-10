class CityNameAsciiToNormalized < ActiveRecord::Migration
  def up
    rename_column :cities, :name_ascii, :name_normalized
    TiRefdata::City.find_each do |city|
      city.name_normalized = 
          city.name_normalized.gsub(/[^a-z]/,' ') if city.name_normalized
      city.save
    end
  end

  def down
    rename_column :cities, :name_normalized, :name_ascii
  end
end
