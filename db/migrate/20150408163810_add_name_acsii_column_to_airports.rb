require "i18n"

class AddNameAcsiiColumnToAirports < ActiveRecord::Migration
  def up
    add_column :airports, :name_acsii, :string
    TiRefdata::Airport.find_each do |airport|
      airport.name_acsii = I18n.transliterate(airport.name).downcase if airport.name
      airport.save
    end
  end

  def down
    remove_column :airports, :name_acsii
  end
end
