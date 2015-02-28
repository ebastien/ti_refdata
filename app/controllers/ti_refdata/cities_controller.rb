# encoding: utf-8

module TiRefdata
  class CitiesController < TiRefdata::ApplicationController
    ensure_signed_in

    def index
      if params[:codes]
        cities = params[:codes].split(',').map { |c| City.find_by_code c }
        cities.compact!
      else
        cities = City.all
      end
      render json: cities, status: (cities.empty? ? 404 : 200)
    end

    def show
      city = City.find_by_code params[:id]
      if city
        render json: city
      else
        render json: {}, status: 404
      end
    end
  end
end
