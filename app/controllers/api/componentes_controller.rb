class Api::ComponentesController < ActionController::API
  include MqttBroker

  def publish
    componente = Componente.find(params[:componente])
    componente.update(estado: params[:mode])
    
    if params[:mode] == 'true'
      mode = 'on'
    else
        mode = 'off'
    end

    publish_mqtt(params[:topico], mode)
  end
end
