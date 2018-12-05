class MqttSubscribeJob < ApplicationJob
  require 'rubygems'
  require 'mqtt'

  queue_as :critical

  def perform(*_args)
    topicos = []
    ComponenteAmbiente.all.each do |_componente_ambiente|
      topicos.push(_componente_ambiente.topico).split(',') unless topicos.include? _componente_ambiente.topico
    end

    uri = URI.parse ENV['CLOUDMQTT_URL']
      conn_opts = {
        remote_host: uri.host,
        remote_port: uri.port,
        username: uri.user,
        password: uri.password,
      }

    Thread.new do
      MQTT::Client.connect(conn_opts) do |_client|
        _client.subscribe(topicos)
        _client.get do |topic, message|
          puts 'topico: ' + topic + ' message: ' + message

          estado = false
          estado = true if message == 'ligar'

          componentes_ambientes = ComponenteAmbiente.where(topico: topic)
          if componentes_ambientes.present?
            componentes_ambientes.each do |componente_ambiente|
              componente_ambiente.update!(estado: estado, valor: message)
            end
            #ComponenteAmbienteBroadcastJob.perform_later(componente_ambiente)
          else
            Rails.logger.error('Erro no atualizar estado do componente ambiente')
          end
        end
      end
    end
  end
end
