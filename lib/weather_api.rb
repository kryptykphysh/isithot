require_relative "./weather_api/response"
require_relative "./weather_api/service_error"
require "rest-client"

module WeatherAPI
  def postcode_forecast(postcode)
    response = RestClient.get(
      "https://api.weatherapi.com/v1/forecast.json",
      params: {
        key: Rails.application.credentials.weather_api_key,
        q: postcode,
        days: 0
      }
    )
    unless response.code == 200
      raise ServiceError.new("service returned a non-200 status", {code: response.code})
    end
    Response.new(JSON.parse(response.body))
  end
end
