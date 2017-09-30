class Api::ComponentesController < ActionController::API
  include MqttBroker

  def publish
    componente = Componente.find(params[:componente])
    if params[:acao].include? "off" or params[:acao].include? "on"
      if params[:acao] == 'power-off'
        estado = false
      else
        estado = true
      end
      componente.update(estado: estado)
    end

    publish_mqtt(params[:topico], params[:acao])
  end
end
