require "i18n"

class AddNameAsciiColumnToCountries < ActiveRecord::Migration
  def up
    add_column :countries, :name_ascii, :string
    TiRefdata::Country.find_each do |country|
      country.name_ascii = I18n.transliterate(country.name).downcase if country.name
      country.save
    end
  end

  def down
    remove_column :countries, :name_ascii
  end
end
