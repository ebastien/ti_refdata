# encoding: utf-8

class TypeCitiesPageRankAsFloat < ActiveRecord::Migration
  def up
    change_column :cities, :page_rank, :float, default: 0
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
