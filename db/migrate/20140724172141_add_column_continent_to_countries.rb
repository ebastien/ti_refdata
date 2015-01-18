# encoding: utf-8

class AddColumnContinentToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :continent, :string
  end
end
