class MqttBrokerJob < ApplicationJob
  require 'rubygems'
  require 'mqtt'

  queue_as :default

  def perform(topic, state)
    MQTT::Client.connect('iot.eclipse.org', 1883) do |c|
      c.publish(topic, state)
    end
  end

end
