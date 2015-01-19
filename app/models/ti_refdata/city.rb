# encoding: utf-8

module TiRefdata
  class City < ActiveRecord::Base
    attr_accessible :code, :name, :latitude, :longitude, :page_rank

    belongs_to :country
  end
end
