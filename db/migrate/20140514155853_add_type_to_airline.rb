# encoding: utf-8

class AddTypeToAirline < ActiveRecord::Migration
  def change
    add_column :airlines, :type_code, :string, default: ''
  end
end
