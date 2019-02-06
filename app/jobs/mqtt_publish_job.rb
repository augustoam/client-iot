class MqttPublishJob < ApplicationJob
  require 'mqtt'

  queue_as :critical

  def perform(automacao_grupo_id)
    p 'CHEGOU CARALHO -----------------------------------------------------'
    uri = URI.parse ENV['CLOUDMQTT_URL']
      conn_opts = {
        remote_host: uri.host,
        remote_port: uri.port,
        username: uri.user,
        password: uri.password,
      }

    msg = {
      automacao_grupo_id: automacao_grupo_id
    }.to_json

    MQTT::Client.connect(conn_opts) do |_client|
      _client.publish('complete_timer', msg)
    end
  end
end
