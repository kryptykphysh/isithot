require "rails_helper"

RSpec.describe TemperatureDefinition, type: :model do
  let(:temp_def) { build :temperature_definition }

  describe "instance variables" do
    context "without a :max" do
      before { temp_def.max = nil }

      it "is invalid" do
        expect(temp_def).to be_invalid
      end
    end

    context "without a :min" do
      before { temp_def.min = nil }

      it "is invalid" do
        expect(temp_def).to be_invalid
      end
    end

    context "when either :min or :max is non-numeric" do
      %i[min= max=].each do |setter|
        before { temp_def.public_send(setter, nil) }

        it "is invalid" do
          expect(temp_def).to be_invalid
        end
      end
    end

    [0, 1, -100.1, 100, 100.1].each do |temp|
      context "when :min is equal to :max" do
        before do
          temp_def.min = temp
          temp_def.max = temp
        end

        it "is valid" do
          expect(temp_def).to be_valid
        end
      end

      context "when :min is less than :max" do
        before do
          temp_def.min = temp - 0.1
          temp_def.max = temp
        end

        it "is valid" do
          expect(temp_def).to be_valid
        end
      end

      context "when :min is greater than :max" do
        before do
          temp_def.min = temp + 0.1
          temp_def.max = temp
        end

        it "is invalid" do
          expect(temp_def).to be_invalid
        end
      end
    end
  end
end
