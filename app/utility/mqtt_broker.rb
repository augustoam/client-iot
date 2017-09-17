module MqttBroker
  require 'rubygems'
  require 'mqtt'

  def publish_mqtt(topico, state)
    MQTT::Client.connect('iot.eclipse.org', 1883) do |client|
      client.publish(topico, state)
    end
  end
end
