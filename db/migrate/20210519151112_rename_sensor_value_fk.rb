class RenameSensorValueFk < ActiveRecord::Migration[6.1]
  def change
    rename_column :data_sensor_values, :sensor_id, :data_sensor_id
  end
end
