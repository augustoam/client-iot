class Api::ComponentesController < ActionController::API
  include MqttBroker

  def publish
    componente = ComponenteAmbiente.find(params[:componente_ambiente])
    if params[:acao].include? "off" or params[:acao].include? "on"
      if params[:acao] == 'power-off'
        estado = false
      else
        estado = true
      end
      componente.update(estado: estado)
    end

    publish_mqtt(componente.topico, params[:acao])
  end
end
