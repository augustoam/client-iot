class MqttSubscribeJob < ApplicationJob
  require 'rubygems'
  require 'mqtt'

  queue_as :critical

  def perform(*_args)
    topicos = []
    ComponenteAmbiente.all.each do |_componente_ambiente|
      topicos.push(_componente_ambiente.topico).split(',') unless topicos.include? _componente_ambiente.topico
    end
    #
    # uri = URI.parse 'mqtt://vxpsulcd:71263-zxU-OO@m10.cloudmqtt.com:14792'
    #   conn_opts = {
    #     remote_host: uri.host,
    #     remote_port: uri.port,
    #     username: uri.user,
    #     password: uri.password,
    #   }
    #   debugger
    #
    #   Thread.new do
    #     MQTT::Client.connect(conn_opts) do |c|
    #       # The block will be called when you messages arrive to the topic
    #       c.get('test') do |topic, message|
    #         puts "#{topic}: #{message}"
    #       end
    #     end
    #   end
    #
    #   MQTT::Client.connect(conn_opts) do |c|
    #     # publish a message to the topic 'test'
    #     loop do
    #       c.publish('test', 'Hello World')
    #       sleep 1
    #     end
    #   end
    #
    # MQTT::Client.connect('iot.eclipse.org', 1883) do |_client|
    #   # If you pass a block to the get method, then it will loop
    #   _client.subscribe(topicos)
    #   _client.get do |topic, message|
    #     puts 'topico: ' + topic + ' message: ' + message
    #
    #     estado = false
    #     estado = true if message == 'ligar'
    #
    #     componente_ambiente = ComponenteAmbiente.find_by(topico: topic)
    #     if componente_ambiente.present?
    #       componente_ambiente.update!(estado: estado, valor: message)
    #
    #       ComponenteAmbienteBroadcastJob.perform_later(componente_ambiente)
    #     else
    #       Rails.logger.error('Erro no atualizar estado do componente ambiente')
    #     end
    #   end
    # end
  end
end
