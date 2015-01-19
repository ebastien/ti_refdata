# encoding: utf-8

class AddIndexOnCityCodes < ActiveRecord::Migration
  def change
    add_index :cities, :code
  end
end
