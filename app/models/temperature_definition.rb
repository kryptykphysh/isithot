class TemperatureDefinition < ApplicationRecord
  DEFAULT_MIN = 5
  DEFAULT_MAX = 25

  scope :latest_attributes, -> { order(created_at: :desc)&.first&.attributes&.extract!("min", "max") || {max: DEFAULT_MAX, min: DEFAULT_MIN} }

  validates :max, presence: true
  validates :min, presence: true
  validate :min_not_greater_than_max

  private

  def min_not_greater_than_max
    unless [min, max].all? { |attr| attr.is_a? Numeric }
      errors.add(:temperature_definition, ":min and :max must be numeric, has min: #{min}, max: #{max}")
      return
    end

    if min > max
      errors.add(:temperature_definition, ":min must be less than :max, but has min: #{min}, max: #{max}")
    end
  end
end
