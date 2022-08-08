require "rails_helper"

RSpec.describe "WeatherApis", type: :request do
  describe "POST /lookup" do
    context "with no params" do
      it "returns an unprocessable entity response" do
        post "/weather_api/lookup"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with invalid params" do
      it "returns an unprocessable entity response" do
        post "/weather_api/lookup"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
