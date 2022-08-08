require_relative "../../lib/weather_api"

RSpec.describe WeatherAPI do
  let(:dummy_class) { Class.new { extend WeatherAPI } }

  describe "methods" do
    describe "#postcode_forecast" do
      context "when a non-200 response is returned" do
        before do
          allow(RestClient).to receive(:get) { double("response", code: 500, body: {}.to_json) }
        end

        it "raises a WeatherAPI::ServiceError" do
          expect { dummy_class.postcode_forecast("AB1 2CD") }.to raise_error WeatherAPI::ServiceError
        end
      end

      context "when a valid response is returned" do
        let(:valid_response) do
          {
            location: {country: "UK"},
            forecast: {forecastday: [{day: {maxtemp_c: 12.3}}]}
          }
        end
        context "for a UK region" do
          before do
            allow(RestClient).to receive(:get) { double("response", code: 200, body: valid_response.to_json) }
          end

          it "returns a WeatherAPI::Response object" do
            expect(dummy_class.postcode_forecast("AB1 2CD")).to be_an_instance_of WeatherAPI::Response
          end
        end
      end
    end
  end
end
