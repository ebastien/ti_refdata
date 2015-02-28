# encoding: utf-8

module TiRefdata
  class AirlinesController < TiRefdata::ApplicationController
    ensure_signed_in

    def index
      if params[:code]
        airlines = params[:code].split(',').map { |c| find_airline(c) }
        airlines.compact!
      else
        airlines = Airline.all
      end
      render json: airlines, status: (airlines.empty? ? 404 : 200)
    end

    def show
      airline = Airline.find_by_unified_code params[:id]
      if airline
        render json: airline
      else
        render json: {}, status: 404
      end
    end

    protected

    def find_airline(c)
      if c.length == 2
        Airline.find_by_iata_code(c)
      else
        Airline.find_by_icao_code(c)
      end
    end
  end
end
