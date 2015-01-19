# encoding: utf-8

class AddColumnPageRankToCities < ActiveRecord::Migration
  def change
    add_column :cities, :page_rank, :float
  end
end
