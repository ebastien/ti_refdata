require "i18n"

class AddDisplayNameColumnToCountries < ActiveRecord::Migration
  def up
    rename_column :countries, :name, :display_name
    add_column :countries, :name, :string
    TiRefdata::Country.find_each do |country|
      country.name = I18n.transliterate(country.display_name).downcase if country.display_name
      country.save
    end
  end

  def down
    remove_column :countries, :name
    rename_column :countries, :display_name, :name
  end
end
