class CountryNameAsciiToNormalized < ActiveRecord::Migration
  def up
    rename_column :countries, :name_ascii, :name_normalized
    TiRefdata::Country.find_each do |country|
      country.name_normalized = 
        country.name_normalized.gsub(/[^a-z]/,' ') if country.name_normalized
      country.save
    end
  end

  def down
    rename_column :countries, :name_normalized, :name_ascii
  end
end
