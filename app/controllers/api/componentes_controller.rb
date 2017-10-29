class Api::ComponentesController < ActionController::API
  include MqttBroker

  def publish
    componente = Componente.find(params[:componente])
    LogComponente.create!(comando: params[:acao], componente: componente, grupo: componente.ambiente.grupo, usuario: current_usuario)

    if params[:acao].include? "off" or params[:acao].include? "on"
      if params[:acao].include? 'off'
        estado = false
      else
        estado = true
      end
      componente.update!(estado: estado)
    end

    publish_mqtt(params[:topico], params[:acao])
  end

  def recebe_estado
    estado = false
    estado = true  if params[:estado] == 'ligar'

    componente = Componente.find_by(identificador_componente: params[:identificador_componente])
    componente.update!(estado: estado)
  end
end
