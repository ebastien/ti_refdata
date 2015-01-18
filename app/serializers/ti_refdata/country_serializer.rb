# encoding: utf-8

module TiRefdata
  class CountrySerializer < ActiveModel::Serializer
    attributes :id, :code, :name, :region

    def id
      code
    end
  end
end
