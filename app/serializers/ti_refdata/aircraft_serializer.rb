# encoding: utf-8

module TiRefdata
  class AircraftSerializer < ActiveModel::Serializer
    attributes :id, :code, :manufacturer, :name

    def id
      code
    end
  end
end
