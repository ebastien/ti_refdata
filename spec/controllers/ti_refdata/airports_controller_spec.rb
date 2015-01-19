# encoding: utf-8
require 'rails_helper'

describe TiRefdata::AirportsController do

  let!(:user) { Fabricate(:user) }
  let!(:country) { Fabricate(:country) }
  let!(:paris_cdg) { Fabricate(:airport) }
  let!(:bordeaux) { Fabricate(:airport, code: 'BOD', name: 'Bordeaux') }

  describe 'GET index with filter' do
    it 'returns our airport when authenticated' do
      sign_in user
      get :index, codes: 'CDG'
      expect(response.status).to eq(200)
      expect(first_json_at '$.airports').to have(1).airport
      expect(first_json_at '$.airports[0].id').to eq('CDG')
      expect(first_json_at '$.airports[0].code').to eq('CDG')
      expect(first_json_at '$.airports[0].name').to eq('Paris - Charles-de-Gaulle')
      expect(first_json_at '$.airports[0].country.code').to eq('FR')
      get :index, codes: 'BOD'
      expect(response.status).to eq(200)
      expect(first_json_at '$.airports').to have(1).airport
      expect(first_json_at '$.airports[0].id').to eq('BOD')
      expect(first_json_at '$.airports[0].code').to eq('BOD')
      expect(first_json_at '$.airports[0].name').to eq('Bordeaux')
      expect(first_json_at '$.airports[0].country.code').to eq('FR')
    end

    it 'returns our airports when authenticated' do
      sign_in user
      get :index, codes: 'CDG,BOD'
      expect(response.status).to eq(200)
      expect(first_json_at '$.airports').to have(2).airports
      expect(first_json_at '$.airports[0].id').to eq('CDG')
      expect(first_json_at '$.airports[0].code').to eq('CDG')
      expect(first_json_at '$.airports[0].name').to eq('Paris - Charles-de-Gaulle')
      expect(first_json_at '$.airports[0].country.code').to eq('FR')
      expect(first_json_at '$.airports[1].id').to eq('BOD')
      expect(first_json_at '$.airports[1].code').to eq('BOD')
      expect(first_json_at '$.airports[1].name').to eq('Bordeaux')
      expect(first_json_at '$.airports[1].country.code').to eq('FR')
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
      expect(first_json_at '$.airports').to have(2).airports
    end
  end

  describe 'GET show' do
    it 'returns our airport when authenticated' do
      sign_in user
      get :show, id: 'CDG'
      expect(first_json_at '$.airport.id').to eq('CDG')
      expect(first_json_at '$.airport.code').to eq('CDG')
      expect(first_json_at '$.airport.name').to eq('Paris - Charles-de-Gaulle')
      expect(first_json_at '$.airport.country.code').to eq('FR')
      expect(response.status).to eq(200)
    end

    it 'fails when not found' do
      sign_in user
      get :show, id: 'not_here'
      expect(response.status).to eq(404)
    end

    it 'returns an error without authentication' do
      pending("authentication not implemented")
      get :show, id: 'CDG'
      expect(response.status).to eq(401)
    end
  end
end
