class SensorsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    sensor_name = params[:sensor]
    sensor_value = params[:value]

    sensor_2_name = params[:sensor2]
    sensor_2_value = params[:value2]

    sensor = DataSensor.find_or_create_by(name: sensor_name)
    sensor.data_sensor_values.create(value: sensor_value)

    if sensor_2_name
      sensor2 = DataSensor.find_or_create_by(name: sensor_2_name)
      sensor2.data_sensor_values.create(value: sensor_2_value)
    end
  end
end
