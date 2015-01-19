# encoding: utf-8
require 'rails_helper'

describe TiRefdata::CitiesController do

  let!(:user) { Fabricate(:user) }
  let!(:france) { Fabricate(:country) }
  let!(:nice) { Fabricate(:city, country: france) }
  let!(:bordeaux) do
    Fabricate(:city, country: france, code: 'BOD', name: 'Bordeaux')
  end

  describe 'GET index with filter' do
    it 'returns our city when authenticated' do
      sign_in user
      get :index, codes: 'NCE'
      expect(response.status).to eq(200)
      expect(first_json_at '$.cities').to have(1).city
      expect(first_json_at '$.cities[0].id').to eq('NCE')
      expect(first_json_at '$.cities[0].code').to eq('NCE')
      expect(first_json_at '$.cities[0].name').to eq('Nice')
      expect(first_json_at '$.cities[0].country.code').to eq('FR')
      get :index, codes: 'BOD'
      expect(response.status).to eq(200)
      expect(first_json_at '$.cities').to have(1).city
      expect(first_json_at '$.cities[0].id').to eq('BOD')
      expect(first_json_at '$.cities[0].code').to eq('BOD')
      expect(first_json_at '$.cities[0].name').to eq('Bordeaux')
      expect(first_json_at '$.cities[0].country.code').to eq('FR')
    end

    it 'returns our cities when authenticated' do
      sign_in user
      get :index, codes: 'NCE,BOD'
      expect(response.status).to eq(200)
      expect(first_json_at '$.cities').to have(2).cities
      expect(first_json_at '$.cities[0].id').to eq('NCE')
      expect(first_json_at '$.cities[0].code').to eq('NCE')
      expect(first_json_at '$.cities[0].name').to eq('Nice')
      expect(first_json_at '$.cities[0].country.code').to eq('FR')
      expect(first_json_at '$.cities[1].id').to eq('BOD')
      expect(first_json_at '$.cities[1].code').to eq('BOD')
      expect(first_json_at '$.cities[1].name').to eq('Bordeaux')
      expect(first_json_at '$.cities[1].country.code').to eq('FR')
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
      expect(first_json_at '$.cities').to have(2).cities
    end
  end

  describe 'GET show' do
    it 'returns our city when authenticated' do
      sign_in user
      get :show, id: 'NCE'
      expect(first_json_at '$.city.id').to eq('NCE')
      expect(first_json_at '$.city.code').to eq('NCE')
      expect(first_json_at '$.city.name').to eq('Nice')
      expect(first_json_at '$.city.country.code').to eq('FR')
      expect(response.status).to eq(200)
    end

    it 'fails when not found' do
      sign_in user
      get :show, id: 'not_here'
      expect(response.status).to eq(404)
    end

    it 'returns an error without authentication' do
      pending("authentication not implemented")
      get :show, id: 'NCE'
      expect(response.status).to eq(401)
    end
  end
end
