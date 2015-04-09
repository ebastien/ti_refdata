# encoding: utf-8
require 'rails_helper'

describe TiRefdata::Airline do
  it 'persists to the store' do
    airl = TiRefdata::Airline.new unified_code: '6X'
    airl.name = 'Amadeus Six'
    airl.name_ascii = 'amadeus six'
    airl.icao_code = 'XYB'
    airl.iata_code = '6X'
    airl.numeric_code = 172
    airl.alliance_code = '1A'
    airl.alliance_status = 'Member'
    airl.type_code = 'D'
    airl.save
    c = TiRefdata::Airline.find airl.id
    expect(c.unified_code).to eq('6X')
    expect(c.name).to eq('Amadeus Six')
    expect(c.name_ascii).to eq('amadeus six')
    expect(c.icao_code).to eq('XYB')
    expect(c.iata_code).to eq('6X')
    expect(c.numeric_code).to eq(172)
    expect(c.alliance_code).to eq('1A')
    expect(c.alliance_status).to eq ('Member')
    expect(c.type_code).to eq ('D')
  end

  it 'filters out non regular airlines' do
    a1 = Fabricate(:airline)
    a2 = Fabricate(:airline_nil_values)
    Fabricate(:dummy_airline)
    Fabricate(:gds)
    Fabricate(:cargo_airline)
    Fabricate(:railway)

    expect(TiRefdata::Airline.regular_airline).to eq([a1,a2])
  end
end
