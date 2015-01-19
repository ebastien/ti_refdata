# encoding: utf-8

module TiRefdata
  class CitySerializer < ActiveModel::Serializer
    attributes :id, :code, :name, :latitude, :longitude
    has_one :country

    def id
      code
    end
  end
end
