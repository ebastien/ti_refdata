require 'rails-api/action_controller/api'
require 'ti_rails_auth/controller'

module TiRefdata
  class ApplicationController < ActionController::API
    include TiRailsAuth::Controller
  end
end
