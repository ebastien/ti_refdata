# encoding: utf-8

module TiRefdata
  class AirportSerializer < ActiveModel::Serializer
    attributes :id, :code, :name, :latitude, :longitude

    has_one :city
    has_one :country

    def id
      code
    end
  end
end
