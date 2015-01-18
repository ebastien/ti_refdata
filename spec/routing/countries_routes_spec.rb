# encoding: utf-8
require 'rails_helper'

describe 'routing to countries API' do

  it 'routes GET /countries to countries#index' do
    expect(get: '/countries').to route_to(
      controller: 'ti_refdata/countries', action: 'index')
  end

  it 'does not route POST' do
    expect(post: '/countries').not_to be_routable
  end

  it 'does not route DELETE' do
    expect(delete: '/countries').not_to be_routable
  end
end
