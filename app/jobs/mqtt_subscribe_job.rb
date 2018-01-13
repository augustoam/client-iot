class MqttSubscribeJob < ApplicationJob
  require 'rubygems'
  require 'mqtt'

  queue_as :critical

  def perform(*_args)
    MQTT::Client.connect('iot.eclipse.org', 1883) do |_client|
      # If you pass a block to the get method, then it will loop
      _client.get('augusto.albertoni@gmail.com/estados') do |topic, message|
        puts "#{topic}: #{message}"
        m = message.split
        estado = false
        estado = true if m[0] == 'power-on'

        componente = Componente.find_by(identificador_componente: m[1])
        componente.update!(estado: estado)

        ComponenteBroadcastJob.perform_later
      end
    end
  end
end
