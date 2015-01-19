# encoding: utf-8

class AddIndexOnAirportCodes < ActiveRecord::Migration
  def change
    add_index :airports, :code
  end
end
