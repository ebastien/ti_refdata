# encoding: utf-8
require 'rails_helper'

describe TiRefdata::AircraftController do

  let!(:user) { Fabricate(:user) }
  let!(:aircraft) do
    Fabricate(:aircraft)
    Fabricate(:aircraft, code: '777', name: '777')
  end

  describe 'GET index with filter' do
    it 'returns our aircraft when authenticated' do
      sign_in user
      get :index, codes: '777'
      expect(response.status).to eq(200)
      expect(first_json_at '$.aircraft').to have(1).aircraft
      expect(first_json_at '$.aircraft[0].id').to eq('777')
      expect(first_json_at '$.aircraft[0].code').to eq('777')
      expect(first_json_at '$.aircraft[0].name').to eq('777')
      get :index, codes: '77W'
      expect(response.status).to eq(200)
      expect(first_json_at '$.aircraft').to have(1).aircraft
      expect(first_json_at '$.aircraft[0].id').to eq('77W')
      expect(first_json_at '$.aircraft[0].code').to eq('77W')
      expect(first_json_at '$.aircraft[0].name').to eq('777-300ER')
    end

    it 'returns our aircraft when authenticated' do
      sign_in user
      get :index, codes: '777,77W'
      expect(response.status).to eq(200)
      expect(first_json_at '$.aircraft').to have(2).aircraft
      expect(first_json_at '$.aircraft[0].id').to eq('777')
      expect(first_json_at '$.aircraft[0].code').to eq('777')
      expect(first_json_at '$.aircraft[0].name').to eq('777')
      expect(first_json_at '$.aircraft[1].id').to eq('77W')
      expect(first_json_at '$.aircraft[1].code').to eq('77W')
      expect(first_json_at '$.aircraft[1].name').to eq('777-300ER')
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
      expect(first_json_at '$.aircraft').to have(2).aircraft
    end
  end

  describe 'GET show' do
    it 'returns our aircraft when authenticated' do
      sign_in user
      get :show, id: '777'
      expect(first_json_at '$.aircraft.id').to eq('777')
      expect(first_json_at '$.aircraft.code').to eq('777')
      expect(first_json_at '$.aircraft.name').to eq('777')
      expect(response.status).to eq(200)
    end

    it 'fails when not found' do
      sign_in user
      get :show, id: 'not_here'
      expect(response.status).to eq(404)
    end

    it 'returns an error without authentication' do
      pending("authentication not implemented")
      get :show, id: '777'
      expect(response.status).to eq(401)
    end
  end
end
