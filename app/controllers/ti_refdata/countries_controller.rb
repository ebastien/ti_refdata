# encoding: utf-8

module TiRefdata
  class CountriesController < ApplicationController
    ensure_signed_in

    def index
      countries = if params[:code]
                    country = Country.find_by_code params[:code]
                    country ? [country] : []
                  else
                    Country.all
                  end

      render json: countries, status: (countries.empty? ? 404 : 200)
    end

    def show
      country = Country.find_by_code params[:id]
      if country
        render json: country
      else
        render json: {}, status: 404
      end
    end
  end
end
