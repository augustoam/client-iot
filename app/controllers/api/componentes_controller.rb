class Api::ComponentesController < ActionController::API
  include MqttBroker

  def publish
    componente_ambiente = ComponenteAmbiente.find(params[:componente_ambiente])
    # LogComponente.create!(comando: params[:acao], componente: componente_ambiente, grupo: componente_ambiente.ambiente.grupo, usuario: current_usuario)

    if params[:acao].include?('ligar') || params[:acao].include?('desligar')
      estado = if params[:acao].include? 'desligar'
                 false
               else
                 true
               end
      componente_ambiente.update!(estado: estado)
    end

    publish_mqtt(componente_ambiente.topico, params[:acao])
  end

  def recebe_estado
    estado = false
    estado = true if params[:estado] == 'ligar'

    componente = Componente.find_by(identificador_componente: params[:identificador_componente])
    componente.update!(estado: estado)
  end
end
