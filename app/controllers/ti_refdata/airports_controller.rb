# encoding: utf-8

module TiRefdata
  class AirportsController < ApplicationController
    ensure_signed_in

    def index
      if params[:codes]
        airports = params[:codes].split(',').map { |c| Airport.find_by_code c }
        airports.compact!
      else
        airports = Airport.all
      end
      render json: airports, status: (airports.empty? ? 404 : 200)
    end

    def show
      airport = Airport.find_by_code params[:id]
      if airport
        render json: airport
      else
        render json: {}, status: 404
      end
    end
  end
end
