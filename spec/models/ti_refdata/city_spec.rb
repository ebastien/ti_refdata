# encoding: utf-8
require 'rails_helper'

describe TiRefdata::City do
  it 'persists to the store' do
    fr = TiRefdata::Country.new code: 'FR'
    fr.name = 'France'
    fr.save
    nce = TiRefdata::City.new code: 'NCE'
    nce.name = 'Nice'
    nce.name_ascii = 'nice'
    nce.latitude = 43.70313
    nce.longitude = 7.26608
    nce.country = fr
    nce.save
    c = TiRefdata::City.find nce.id
    expect(c.code).to eq('NCE')
    expect(c.name).to eq('Nice')
    expect(c.name_ascii).to eq('nice')
    expect(c.latitude).to eq(43.70313)
    expect(c.longitude).to eq(7.26608)
    expect(c.country.code).to eq('FR')
    expect(c.country.name).to eq('France')
  end
end
