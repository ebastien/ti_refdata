# encoding: utf-8

class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :code,   null: false
      t.string :name,   null: true
      t.decimal :latitude,   null: true
      t.decimal :longitude,  null: true
      t.references :country
    end
  end
end
