# encoding: utf-8

class CreateAircraft < ActiveRecord::Migration
  def change
    create_table :aircraft do |t|
      t.string :code,  null: false
      t.string :manufacturer,  null: false
      t.string :name,  null: false
    end
  end
end
