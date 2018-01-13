require 'rubygems'
require 'mqtt'

class MqttService
  def self.subscribe_mqtt
    MQTT::Client.connect('iot.eclipse.org', 1883) do |_client|
      # If you pass a block to the get method, then it will loop
      _client.get('augusto.albertoni@gmail.com/room/lights') do |topic, message|
        puts "#{topic}: #{message}"
      end
    end
  end
end
