require "i18n"

class AddDisplayNameColumnToAirports < ActiveRecord::Migration
  def up
    rename_column :airports, :name, :display_name
    add_column :airports, :name, :string
    TiRefdata::Airport.find_each do |airport|
      airport.name = I18n.transliterate(airport.display_name).downcase if airport.display_name
      airport.save
    end
  end

  def down
    remove_column :airports, :name
    rename_column :airports, :display_name, :name
  end
end
