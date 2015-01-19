# encoding: utf-8

class AddColumnCityToAirports < ActiveRecord::Migration
  def change
    add_column :airports, :city_id, :integer
  end
end
