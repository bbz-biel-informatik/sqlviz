class SensorsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    sensor_name = params[:sensor]
    sensor_value = params[:value]

    sensor = Sensor.find_or_create_by(name: sensor_name)
    sensor.values.create(value: sensor_value)
  end
end
