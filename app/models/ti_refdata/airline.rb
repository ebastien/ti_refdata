# encoding: utf-8

module TiRefdata
  class Airline < ActiveRecord::Base
    attr_accessible :unified_code, :icao_code, :iata_code, :numeric_code,
                    :name, :name_ascii, :name2_ascii,
                    :alliance_code, :alliance_status,
                    :type_code, :page_rank

    def self.with_name
      where('name IS NOT NULL')
    end

    def self.regular_airline
      where("(type_code IS NULL) OR (type_code NOT IN ('C','D','G','R'))")
    end
  end
end
