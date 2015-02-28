require 'rails-api/action_controller/api'
require 'ti_devise_auth/controller'

module TiRefdata
  class ApplicationController < ActionController::API
    include TiDeviseAuth::Controller
  end
end
