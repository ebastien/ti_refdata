require "i18n"

class AddNameAcsiiColumnToCountries < ActiveRecord::Migration
  def up
    add_column :countries, :name_acsii, :string
    TiRefdata::Country.find_each do |country|
      country.name_acsii = I18n.transliterate(country.name).downcase if country.name
      country.save
    end
  end

  def down
    remove_column :countries, :name_acsii
  end
end
