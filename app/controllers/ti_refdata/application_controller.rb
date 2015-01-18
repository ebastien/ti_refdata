require 'rails-api/action_controller/api'

module TiRefdata
  class ApplicationController < ActionController::API

    def user_signed_in?
      true
    end

    protected

    def self.ensure_signed_in
      before_filter { invalid_credentials unless user_signed_in? }
    end

    def render_error(code)
      render json: {}, status: code
    end

    def invalid_credentials
      render_error 401
    end
  end
end
