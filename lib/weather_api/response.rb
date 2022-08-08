require "active_support/core_ext/hash/keys"

module WeatherAPI
  class Response
    def initialize(raw_hash)
      raise ArgumentError, "required argument to ::new must be a Hash" unless raw_hash.is_a?(Hash)
      @raw_hash = raw_hash.deep_symbolize_keys
    end

    def is_uk?
      @raw_hash.dig(:location, :country) == "UK"
    end

    def max_temp
      day_forecast[:maxtemp_c]
    end

    private

    def day_forecast
      return {} unless forecast.size > 0 && forecast.first.is_a?(Hash)
      raw_day = forecast.first.fetch(:day, {})
      raw_day.is_a?(Hash) ? raw_day : {}
    end

    def forecast
      raw_forecast = @raw_hash.dig(:forecast, :forecastday)
      raw_forecast.is_a?(Array) ? raw_forecast : []
    end
  end
end
