# encoding: utf-8
require 'rails_helper'

describe TiRefdata::AirlinesController do

  let!(:user) { Fabricate(:user) }
  let!(:airline) do
    Fabricate(:dummy_airline)
    Fabricate(:airline, unified_code: '6X', iata_code: '6X', name: 'Amadeus Six', type_code: '')
  end

  describe 'GET index with filter' do
    it 'returns our airline when authenticated' do
      sign_in user
      get :index, code: '6X'
      expect(response.status).to eq(200)
      expect(first_json_at '$.airlines').to have(1).airline
      expect(first_json_at '$.airlines[0].id').to eq('6X')
      expect(first_json_at '$.airlines[0].unified_code').to eq('6X')
      expect(first_json_at '$.airlines[0].name').to eq('Amadeus Six')
      expect(first_json_at '$.airlines[0].type_code').to eq('')
      get :index, code: '7X'
      expect(response.status).to eq(200)
      expect(first_json_at '$.airlines').to have(1).airline
      expect(first_json_at '$.airlines[0].id').to eq('7X')
      expect(first_json_at '$.airlines[0].unified_code').to eq('7X')
      expect(first_json_at '$.airlines[0].name').to eq('Amadeus Seven')
      expect(first_json_at '$.airlines[0].type_code').to eq('D')
    end

    it 'returns our airlines when authenticated' do
      sign_in user
      get :index, code: '6X,7X'
      expect(response.status).to eq(200)
      expect(first_json_at '$.airlines').to have(2).airlines
      expect(first_json_at '$.airlines[0].id').to eq('6X')
      expect(first_json_at '$.airlines[0].unified_code').to eq('6X')
      expect(first_json_at '$.airlines[0].name').to eq('Amadeus Six')
      expect(first_json_at '$.airlines[1].id').to eq('7X')
      expect(first_json_at '$.airlines[1].unified_code').to eq('7X')
      expect(first_json_at '$.airlines[1].name').to eq('Amadeus Seven')
    end

    it 'returns an error without authentication' do
      pending("authentication not implemented")
      get :index
      expect(response.status).to eq(401)
    end
  end

  describe 'GET index without filter' do
    it 'returns an error' do
      sign_in user
      get :index
      expect(response.status).to eq(200)
      expect(first_json_at '$.airlines').to have(2).airlines
    end
  end

  describe 'GET show' do
    it 'returns our airline when authenticated' do
      sign_in user
      get :show, id: '6X'
      expect(first_json_at '$.airline.id').to eq('6X')
      expect(first_json_at '$.airline.unified_code').to eq('6X')
      expect(first_json_at '$.airline.name').to eq('Amadeus Six')
      expect(response.status).to eq(200)
    end

    it 'fails when not found' do
      sign_in user
      get :show, id: 'not_here'
      expect(response.status).to eq(404)
    end

    it 'returns an error without authentication' do
      pending("authentication not implemented")
      get :show, id: '6X'
      expect(response.status).to eq(401)
    end
  end
end
