# encoding: utf-8

class CreateAirlines < ActiveRecord::Migration
  def change
    create_table :airlines do |t|
      t.string :unified_code,   null: false
      t.string :icao_code,  null: true
      t.string :iata_code,  null: true
      t.integer :numeric_code , null: true
      t.string :name,  null: true
      t.string :name2,  null: true
      t.string :alliance_code,  null: true
      t.string :alliance_status, null: true
    end
  end
end
