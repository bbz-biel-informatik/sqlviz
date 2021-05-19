class RenameSensorTables < ActiveRecord::Migration[6.1]
  def change
    rename_table :sensors, :data_sensors
    rename_table :sensor_values, :data_sensor_values
  end
end
