class Api::V1::MqttController < Api::V1::BaseController
  include MqttBroker

  def publish
    parametros = JSON.parse(params[:parametros])
    device = RoomDevice.find(parametros['room_device']['id'])
    if parametros['msg'].include? "off" or parametros['msg'].include? "on"
      if parametros['msg'] == 'power-off'
        estado = false
      else
        estado = true
      end
      device.update(estado: estado)
    end

    publish_mqtt(device.topico, parametros['msg'])
  end
end
