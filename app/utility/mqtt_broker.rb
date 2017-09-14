module MqttBroker
  require 'rubygems'
  require 'mqtt'

  def publish_mqtt(topic, state)
    MQTT::Client.connect('iot.eclipse.org', 1883) do |c|
      c.publish(topic, state)
    end
  end
  
end