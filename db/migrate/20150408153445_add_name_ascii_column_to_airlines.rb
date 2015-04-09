require "i18n"

class AddNameAsciiColumnToAirlines < ActiveRecord::Migration
  def up
    add_column :airlines, :name_ascii, :string
    rename_column :airlines, :name2, :name2_ascii
    TiRefdata::Airline.find_each do |airline|
      airline.name_ascii = I18n.transliterate(airline.name).downcase if airline.name
      airline.name2_ascii = I18n.transliterate(airline.name2_ascii).downcase if airline.name2_ascii
      airline.save
    end
  end

  def down
    remove_column :airlines, :name_ascii
    rename_column :airlines, :name2_ascii, :name2
  end

end
