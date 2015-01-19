# encoding: utf-8

class AddColumnPageRankToAirlines < ActiveRecord::Migration
  def change
    add_column :airlines, :page_rank, :float
  end
end
