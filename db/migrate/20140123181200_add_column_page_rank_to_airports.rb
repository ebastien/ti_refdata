# encoding: utf-8

class AddColumnPageRankToAirports < ActiveRecord::Migration
  def change
    add_column :airports, :page_rank, :float
  end
end
