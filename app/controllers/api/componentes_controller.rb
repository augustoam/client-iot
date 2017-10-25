class Api::ComponentesController < ActionController::API
  include MqttBroker

  def publish
    puts params
    componente = Componente.find(params[:componente])
    LogComponente.create!(comando: params[:acao], componente: componente, grupo: componente.ambiente.grupo, usuario: current_usuario)

    if params[:acao].include? "off" or params[:acao].include? "on"
      if params[:acao].include? 'off'
        estado = false
      else
        estado = true
      end
      componente.update(estado: estado)
    end

    publish_mqtt(params[:topico], params[:acao])
  end
end
