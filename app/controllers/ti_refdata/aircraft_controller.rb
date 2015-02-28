# encoding: utf-8

module TiRefdata
  class AircraftController < TiRefdata::ApplicationController
    ensure_signed_in

    def index
      if params[:codes]
        aircraft = params[:codes].split(',').map { |c| Aircraft.find_by_code c }
        aircraft.compact!
      else
        aircraft = Aircraft.all
      end
      render json: aircraft, status: (aircraft.empty? ? 404 : 200)
    end

    def show
      aircraft = Aircraft.find_by_code params[:id]
      if aircraft
        render json: aircraft
      else
        render json: {}, status: 404
      end
    end
  end
end
