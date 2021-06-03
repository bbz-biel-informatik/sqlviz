class CreateSensorValues < ActiveRecord::Migration[6.1]
  def change
    create_table :sensor_values do |t|
      t.references :sensor, null: false, foreign_key: true
      t.float :value

      t.timestamps
    end
  end
end
