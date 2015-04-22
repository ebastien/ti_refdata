# encoding: utf-8
require 'csv'
require "i18n"

module TiRefdata
  class PorManager
    TMP_DIR = './tmp'
    TMP_OPTD_POR = TMP_DIR + '/optd_por_public.csv'
    TMP_OPTD_AIRLINES = TMP_DIR + '/optd_airlines.csv'
    TMP_OPTD_AIRCRAFT = TMP_DIR + '/optd_aircraft.csv'
    TMP_OPTD_REGION_DETAILS = TMP_DIR + '/optd_region_details.csv'

    OPTD_POR_SOURCE = 'https://raw.githubusercontent.com/opentraveldata/opentraveldata/master/opentraveldata/optd_por_public.csv'
    OPTD_AIRLINES_SOURCE = 'https://raw.githubusercontent.com/opentraveldata/opentraveldata/master/opentraveldata/optd_airlines.csv'
    OPTD_AIRCARFT_SOURCE = 'https://raw.githubusercontent.com/opentraveldata/opentraveldata/master/opentraveldata/optd_aircraft.csv'
    OPTD_REGION_DETAILS_SOURCE = 'https://raw.githubusercontent.com/opentraveldata/opentraveldata/master/opentraveldata/optd_region_details.csv'

    def self.normalize_name(name)
      I18n.transliterate(name).downcase.gsub(/[^a-z0-9]/,' ')
    end

    def self.update_cities
      CSV.foreach(TMP_OPTD_POR, :headers => true, :col_sep => '^', :quote_char => "\x00") do |data|
        code = data['iata_code']
        type = data['location_type']
        if code.present? && (type.include? 'C')
          c = TiRefdata::City.find_by_code(code)
          if c.nil?
            c = TiRefdata::City.create(code: code)
          end
          c.name = data['name']
          c.name_normalized = normalize_name(data['name']) if data['name']
          c.latitude = data['latitude']
          c.longitude = data['longitude']
          country = TiRefdata::Country.find_by_code(data['country_code'])
          c.country = country
          c.page_rank = data['page_rank'].to_f
          c.save
        end
      end
    end

    def self.update_airports
      CSV.foreach(TMP_OPTD_POR, :headers => true, :col_sep => '^', :quote_char => "\x00") do |data|
        code = data['iata_code']
        type = data['location_type']
        if code.present? && (type.include? 'A')
          c = TiRefdata::Airport.find_by_code(code)
          if c.nil?
            c = TiRefdata::Airport.create(code: code)
          end
          c.name = data['name']
          c.name_normalized = normalize_name(data['name']) if data['name']
          c.latitude = data['latitude']
          c.longitude = data['longitude']
          cities = data['city_code_list'].split(',').map { |code| TiRefdata::City.find_by_code(code) }
          c.city = cities.first
          country = TiRefdata::Country.find_by_code(data['country_code'])
          c.country = country
          c.page_rank = data['page_rank'].to_f
          c.save
        end
      end
    end

    def self.update_countries
      CSV.foreach(TMP_OPTD_REGION_DETAILS, :headers => true, :col_sep => '^') do |data|
        code = data['country_code_iso_2char']
        if code.present?
          name = data['country_name']
          region = data['user_country_code_2'][0..1]
          c = TiRefdata::Country.find_by_code(code)
          if c.nil?
            c = TiRefdata::Country.create(code: code)
          end
          c.name = name
          c.name_normalized = normalize_name(name) if name
          c.region = region
          c.page_rank = 1
          c.save
        end
      end
    end

    def self.update_airlines
      codes = Set.new
      CSV.foreach(TMP_OPTD_AIRLINES, :headers => true, :col_sep => '^') do |data|
        code = data['pk']
        if code.present?
          codes.add(code)
          c = TiRefdata::Airline.find_by_unified_code(code)
          if c.nil?
            c = TiRefdata::Airline.create(unified_code: code)
          end
          c.icao_code = data['3char_code']
          c.iata_code = data['2char_code']
          c.numeric_code = data['num_code']
          c.name = data['name']
          c.name_normalized = normalize_name(data['name']) if data['name']
          c.name2_normalized = normalize_name(data['name2']) if data['name2']
          c.alliance_code = data['alliance_code']
          c.alliance_status = data['alliance_status']
          c.type_code = data['type'] if data['type']
          c.page_rank = 1
          c.save
        end
      end
      all = TiRefdata::Airline.all
      all.each do |airline|
        unless codes.include?(airline['unified_code'])
          airline.destroy
          puts 'Orphan airline deleted: ' + airline['unified_code']
        end
      end
    end

    def self.update_aircraft
      CSV.foreach(TMP_OPTD_AIRCRAFT, :headers => true, :col_sep => '^') do |data|
        code = data['iata_code']
        if code.present?
          c = TiRefdata::Aircraft.find_by_code(code)
          if c.nil?
            c = TiRefdata::Aircraft.create(code: code, manufacturer: data['manufacturer'], name: data['model'])
            c.save
          end
        end
      end
    end

    def self.update_optd_por_csv(http_proxy = '')
      Dir.mkdir(TMP_DIR) unless File.exists?(TMP_DIR)
      system("curl -s -S -L -f -x \"#{http_proxy}\" -o #{TMP_OPTD_POR} #{OPTD_POR_SOURCE}")
    end

    def self.update_optd_countries_csv(http_proxy = '')
      Dir.mkdir(TMP_DIR) unless File.exists?(TMP_DIR)
      system("curl -s -S -L -f -x \"#{http_proxy}\" -o #{TMP_OPTD_REGION_DETAILS} #{OPTD_REGION_DETAILS_SOURCE}")
    end

    def self.update_optd_airlines_csv(http_proxy = '')
      Dir.mkdir(TMP_DIR) unless File.exists?(TMP_DIR)
      system("curl -s -S -L -f -x \"#{http_proxy}\" -o #{TMP_OPTD_AIRLINES} #{OPTD_AIRLINES_SOURCE}")
    end

    def self.update_optd_aircraft_csv(http_proxy = '')
      Dir.mkdir(TMP_DIR) unless File.exists?(TMP_DIR)
      system("curl -s -S -L -f -x \"#{http_proxy}\" -o #{TMP_OPTD_AIRCRAFT} #{OPTD_AIRCARFT_SOURCE}")
    end
  end
end
