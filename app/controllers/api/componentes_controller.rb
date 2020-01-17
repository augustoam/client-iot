class Api::DevicesController < ActionController::API
  include MqttBroker

  def publish
    device = RoomDevice.find(params[:room_device])
    if params[:acao].include? "off" or params[:acao].include? "on"
      if params[:acao] == 'power-off'
        estado = false
      else
        estado = true
      end
      device.update(estado: estado)
    end

    publish_mqtt(device.topico, params[:acao])
  end
end
