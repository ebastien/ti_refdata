require "i18n"

class AddNameAcsiiColumnToAirlines < ActiveRecord::Migration
  def up
    add_column :airlines, :name_acsii, :string
    rename_column :airlines, :name2, :name2_acsii
    TiRefdata::Airline.find_each do |airline|
      airline.name_acsii = I18n.transliterate(airline.name).downcase if airline.name
      airline.name2_acsii = I18n.transliterate(airline.name2_acsii).downcase if airline.name2_acsii
      airline.save
    end
  end

  def down
    remove_column :airlines, :name_acsii
    rename_column :airlines, :name2_acsii, :name2
  end

end
