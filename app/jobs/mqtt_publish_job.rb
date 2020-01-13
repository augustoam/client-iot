class MqttPublishJob < ApplicationJob
  require 'mqtt'

  queue_as :critical

  def perform(automacao_group_id, topic = 'COMPLETE_SCHEDULE')
    p "AUTOMACAO EXECUTADA -> AUTOMACAO_GRUPO_ID: #{automacao_group_id}"

    uri = URI.parse ENV['CLOUDMQTT_URL']
      conn_opts = {
        remote_host: uri.host,
        remote_port: uri.port,
        username: uri.user,
        password: uri.password,
      }

    msg = {
      automacao_group_id: automacao_group_id
    }.to_json

    MQTT::Client.connect(conn_opts) do |_client|
      _client.publish(topic, msg)
    end
  end
end
