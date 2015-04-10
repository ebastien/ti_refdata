# encoding: utf-8
require 'rails_helper'

describe TiRefdata::Airport do
  it 'persists to the store' do
    fr = TiRefdata::Country.new code: 'FR'
    fr.name = 'France'
    fr.save
    cdg = TiRefdata::Airport.new code: 'CDG'
    cdg.name = 'Paris - Charles-de-Gaulle'
    cdg.name_normalized = 'paris - charles-de-gaulle'
    cdg.latitude = 49.01278
    cdg.longitude = 2.55
    cdg.country = fr
    cdg.save
    c = TiRefdata::Airport.find cdg.id
    expect(c.code).to eq('CDG')
    expect(c.name).to eq('Paris - Charles-de-Gaulle')
    expect(c.name_normalized).to eq('paris - charles-de-gaulle')
    expect(c.latitude).to eq(49.01278)
    expect(c.longitude).to eq(2.55)
    expect(c.country.code).to eq('FR')
    expect(c.country.name).to eq('France')
  end
end
