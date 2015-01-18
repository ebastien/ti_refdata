# encoding: utf-8

module TiRefdata
  class Country < ActiveRecord::Base
    self.table_name = "countries"

    attr_accessible :code, :name, :region, :page_rank

    has_many :cities
  end
end
