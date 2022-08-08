class HomeController < ApplicationController
  def index
    @temperature_definition = TemperatureDefinition.new(TemperatureDefinition.latest_attributes)
  end
end
