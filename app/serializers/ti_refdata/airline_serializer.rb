# encoding: utf-8

module TiRefdata
  class AirlineSerializer < ActiveModel::Serializer
    attributes :id, :unified_code, :icao_code, :iata_code, :numeric_code,
               :name, :name2, :alliance_code, :alliance_status, :type_code

    def id
      unified_code
    end

    def include_name?
      !name.nil?
    end
  end
end
