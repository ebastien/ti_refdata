# encoding: utf-8

class AddColumnPageRankToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :page_rank, :float
  end
end
