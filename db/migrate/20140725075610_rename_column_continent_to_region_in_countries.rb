# encoding: utf-8

class RenameColumnContinentToRegionInCountries < ActiveRecord::Migration
  def change
    rename_column :countries, :continent, :region
  end
end
