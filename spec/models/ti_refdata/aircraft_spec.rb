# encoding: utf-8
require 'rails_helper'

describe TiRefdata::Aircraft do
  it 'persists to the store' do
    aircr = TiRefdata::Aircraft.new code: '77W'
    aircr.manufacturer = 'Boeing'
    aircr.name = '777-300ER'
    aircr.save
    c = TiRefdata::Aircraft.find aircr.id
    expect(c.code).to eq('77W')
    expect(c.manufacturer).to eq('Boeing')
    expect(c.name).to eq('777-300ER')
  end
end
