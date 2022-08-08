class TemperatureDefinitionsController < ApplicationController
  def create
    @temperature_definition = TemperatureDefinition.new(temp_def_params)
    if @temperature_definition.save!
      @temperature_definition = TemperatureDefinition.new(@temperature_definition.attributes.extract!("min", "max"))
      flash.now[:notice] = "New Temperature Definition created!"
    end
  end

  private

  def temp_def_params
    params.require(:temperature_definition).permit(:max, :min)
  end
end
