require_relative "../../lib/weather_api"

class WeatherApiController < ApplicationController
  include WeatherAPI

  def lookup
    @postcode = params[:postcode].upcase
    @max_warm = params[:max_warm].to_f
    @min_warm = params[:min_warm].to_f

    api_response = postcode_forecast(@postcode)
    if api_response.is_uk? && api_response.max_temp.present?
      @temp = api_response.max_temp
    else
      @errors = "#{@postcode} does not appear to be a valid UK postcode"
    end
  rescue
    @errors = "The weather api cannot currently return a response for postcode #{@postcode}. Please try again later."
  end
end
