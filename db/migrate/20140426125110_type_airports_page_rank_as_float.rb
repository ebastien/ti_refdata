# encoding: utf-8

class TypeAirportsPageRankAsFloat < ActiveRecord::Migration
  def up
    change_column :airports, :page_rank, :float, default: 0
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
