# encoding: utf-8

class TypeAirlinesPageRankAsFloat < ActiveRecord::Migration
  def up
    change_column :airlines, :page_rank, :float, default: 0
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
