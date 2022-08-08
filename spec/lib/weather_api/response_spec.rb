require_relative "../../../lib/weather_api/response"

module WeatherAPI
  RSpec.describe Response do
    describe "class methods" do
      describe "::new" do
        context "when called with no arguments" do
          it "raises an ArgumentError" do
            expect { described_class.new }.to raise_error ArgumentError
          end
        end

        context "when called with an argument that is not a Hash" do
          it "raises an ArgumentError" do
            expect { described_class.new(1) }.to raise_error ArgumentError
          end
        end

        context "when called with a valid Hash" do
          let(:arg) { {"a" => 1, :b => {"c" => 2}} }

          it "creates a new instance with @raw_hash a symbolized version of the arg" do
            expected = {a: 1, b: {c: 2}}
            expect(described_class.new(arg).instance_variable_get(:@raw_hash)).to eq expected
          end
        end
      end
    end

    describe "instance methods" do
      let(:response) do
        described_class.new({
          location: {country: "UK"},
          forecast: {forecastday: [{day: {maxtemp_c: 12.3}}]}
        })
      end

      describe "#is_uk?" do
        context "with a valid UK @raw_hash" do
          it "returns true" do
            expect(response.is_uk?).to be true
          end
        end

        context "with a non UK location" do
          before { response.instance_variable_set(:@raw_hash, {location: {country: "Banana"}}) }

          it "returns false" do
            expect(response.is_uk?).to be false
          end
        end
      end

      describe "#max_temp" do
        context "with a valid hash" do
          it "returns the correct max temp value" do
            expect(response.max_temp).to eq 12.3
          end
        end

        context "with an invalid @raw_hash" do
          before { response.instance_variable_set(:@raw_hash, {}) }

          it "returns nil" do
            expect(response.max_temp).to be_nil
          end
        end
      end
    end
  end
end
