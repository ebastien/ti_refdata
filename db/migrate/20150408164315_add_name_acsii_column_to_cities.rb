require "i18n"

class AddNameAcsiiColumnToCities < ActiveRecord::Migration
  def up
    add_column :cities, :name_acsii, :string
    TiRefdata::City.find_each do |city|
      city.name_acsii = I18n.transliterate(city.name).downcase if city.name
      city.save
    end
  end

  def down
    remove_column :cities, :name_acsii
  end
end
