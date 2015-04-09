require "i18n"

class AddNameAsciiColumnToCities < ActiveRecord::Migration
  def up
    add_column :cities, :name_ascii, :string
    TiRefdata::City.find_each do |city|
      city.name_ascii = I18n.transliterate(city.name).downcase if city.name
      city.save
    end
  end

  def down
    remove_column :cities, :name_ascii
  end
end
