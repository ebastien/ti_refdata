# encoding: utf-8
require 'ti_refdata/por_manager'

class TiRefdata::Airline
  def name_normalized
    read_attribute(:name_normalized) || TiRefdata::PorManager.normalize_name(name)
  end
end

Fabricator(:airline, class_name: TiRefdata::Airline) do
  unified_code 'air-alitalia'
  name 'Alitalia'
  icao_code 'AZA'
  iata_code 'AZ'
  numeric_code 55
  alliance_code 'Skyteam'
  alliance_status 'Member'
  type_code ''
  page_rank 0.8
end

Fabricator(:airline_nil_values, class_name: TiRefdata::Airline) do
  unified_code 'air-ryanair'
  name 'Ryanair'
  icao_code 'RYR'
  iata_code 'FR'
  numeric_code 0
  alliance_code nil
  alliance_status nil
  type_code nil
  page_rank 1.0
end

Fabricator(:dummy_airline, class_name: TiRefdata::Airline) do
  unified_code '7X'
  name 'Amadeus Seven'
  icao_code 'XYC'
  iata_code '7X'
  numeric_code 791
  alliance_code ''
  alliance_status ''
  type_code 'D'
  page_rank 0.3
end

Fabricator(:gds, class_name: TiRefdata::Airline) do
  unified_code '1A'
  name 'Amadeus'
  icao_code 'AGT'
  iata_code '1A'
  numeric_code 790
  alliance_code ''
  alliance_status ''
  type_code 'G'
  page_rank 1
end

Fabricator(:cargo_airline, class_name: TiRefdata::Airline) do
  unified_code 'air-bluebird-cargo'
  name 'Bluebird Cargo'
  icao_code 'BBD'
  iata_code 'BF'
  numeric_code nil
  alliance_code ''
  alliance_status ''
  type_code 'C'
  page_rank 0.1
end

Fabricator(:railway, class_name: TiRefdata::Airline) do
  unified_code 'trn-sncf'
  name 'SNCF'
  icao_code '0'
  iata_code '2C'
  numeric_code 0
  alliance_code ''
  alliance_status ''
  type_code 'R'
  page_rank 0.3
end
