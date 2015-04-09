# encoding: utf-8

module TiRefdata
  class Airport < ActiveRecord::Base
    attr_accessible :code, :name, :name_acsii, :latitude, :longitude, :page_rank

    belongs_to :city
    belongs_to :country
  end
end
