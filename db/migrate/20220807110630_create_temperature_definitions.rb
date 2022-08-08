class CreateTemperatureDefinitions < ActiveRecord::Migration[7.0]
  def change
    create_table :temperature_definitions do |t|
      t.float :min, null: false
      t.float :max, null: false

      t.timestamps
    end
  end
end
