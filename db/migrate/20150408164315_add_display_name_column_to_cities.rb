class AddDisplayNameColumnToCities < ActiveRecord::Migration
  def up
    rename_column :cities, :name, :display_name
    add_column :cities, :name, :string
    TiRefdata::City.find_each do |city|
      city.name = I18n.transliterate(city.display_name).downcase if city.display_name
      city.save
    end
  end

  def down
    remove_column :cities, :name
    rename_column :cities, :display_name, :name
  end
end
