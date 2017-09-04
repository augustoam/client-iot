class HomeController < ApplicationController
  require 'rubygems'
  require 'mqtt'

  def index
  end

  def publish
    MQTT::Client.connect('iot.eclipse.org', 1883) do |c|
      c.publish('augustoalbertoni/teste', 'L')
    end
    redirect_to root_url
  end

  def subscribe
    debugger
    client = MQTT::Client.connect('iot.eclipse.org', 1883)
    res = client.subscribe('augustoalbertoni')
    puts res
    redirect_to root_url
  end

end