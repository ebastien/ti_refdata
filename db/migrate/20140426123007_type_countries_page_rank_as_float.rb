# encoding: utf-8

class TypeCountriesPageRankAsFloat < ActiveRecord::Migration
  def up
    change_column :countries, :page_rank, :float, default: 0
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
