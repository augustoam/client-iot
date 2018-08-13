class Api::V1::MqttController < Api::V1::BaseController
  include MqttBroker

  def publish
    parametros = JSON.parse(params[:parametros])
    componente = ComponenteAmbiente.find(parametros['componente_ambiente']['id'])
    if parametros['msg'].include? "off" or parametros['msg'].include? "on"
      if parametros['msg'] == 'power-off'
        estado = false
      else
        estado = true
      end
      componente.update(estado: estado)
    end

    publish_mqtt(componente.topico, parametros['msg'])
  end
end
