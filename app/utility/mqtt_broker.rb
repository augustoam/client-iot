module MqttBroker
  require 'rubygems'
  require 'mqtt'

  def publish_mqtt(topico, state)
    uri = URI.parse ENV['CLOUDMQTT_URL']
      conn_opts = {
        remote_host: uri.host,
        remote_port: uri.port,
        username: uri.user,
        password: uri.password,
      }

      MQTT::Client.connect(conn_opts) do |_client|
        _client.publish(topico, state)
      end
  end
end
