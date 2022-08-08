module WeatherAPI
  class ServiceError < StandardError
    attr_reader :raw_response

    def initialize(msg = "An error occured calling the weather api", raw_response = {})
      @raw_response = raw_response
      super(msg)
    end
  end
end
