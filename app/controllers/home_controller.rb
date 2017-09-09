class HomeController < ApplicationController
  require 'rubygems'
  require 'mqtt'

  def index
    if admin_signed_in?
      redirect_to admin_home_admin_index_path
    else
      if usuario_signed_in?
        redirect_to grupos_path
      end
    end
  end

  def publish
    MQTT::Client.connect('iot.eclipse.org', 1883) do |c|
      c.publish('augustoalbertoni/teste', 'L')
    end
    redirect_to root_url
  end

  def subscribe
    MQTT::Client.connect('iot.eclipse.org', 1883) do |c|
      c.publish('augustoalbertoni/teste', 'D')
    end
    redirect_to root_url
  end

end