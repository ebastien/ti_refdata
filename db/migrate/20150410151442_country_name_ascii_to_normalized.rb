class CountryNameAsciiToNormalized < ActiveRecord::Migration
  def up
    rename_column :countries, :name_ascii, :name_normalized
    TiRefdata::Country.find_each do |country|
      country.name_normalized.gsub!(/[^a-z]/,' ')
      country.name2_normalized.gsub!(/[^a-z]/,' ')
      country.save
    end
  end

  def down
    rename_column :countries, :name_normalized, :name_ascii
  end
end
