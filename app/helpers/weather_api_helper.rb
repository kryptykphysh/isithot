module WeatherApiHelper
  def weather_result
    if @temp > @max_warm
      "Hot"
    elsif @temp > @min_warm
      "Warm"
    else
      "Cold"
    end
  end
end
