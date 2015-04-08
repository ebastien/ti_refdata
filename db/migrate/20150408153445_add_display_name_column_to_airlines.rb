require "i18n"

class AddDisplayNameColumnToAirlines < ActiveRecord::Migration
  def up
    rename_column :airlines, :name, :display_name
    add_column :airlines, :name, :string
    TiRefdata::Airline.find_each do |airline|
      airline.name = I18n.transliterate(airline.display_name).downcase if airline.display_name
      airline.name2 = I18n.transliterate(airline.name2).downcase if airline.name2
      airline.save
    end
  end

  def down
    remove_column :airlines, :name
    rename_column :airlines, :display_name, :name
  end

end
