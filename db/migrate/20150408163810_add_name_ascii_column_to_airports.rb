require "i18n"

class AddNameAsciiColumnToAirports < ActiveRecord::Migration
  def up
    add_column :airports, :name_ascii, :string
    TiRefdata::Airport.find_each do |airport|
      airport.name_ascii = I18n.transliterate(airport.name).downcase if airport.name
      airport.save
    end
  end

  def down
    remove_column :airports, :name_ascii
  end
end
