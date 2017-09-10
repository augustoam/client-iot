class HomeController < ApplicationController
  require 'rubygems'
  require 'mqtt'

  def index
    if admin_signed_in?
      redirect_to admin_home_admin_index_path
    else
      if usuario_signed_in?
        redirect_to home_console_path
      end
    end
  end

  def mode_on
    MQTT::Client.connect('iot.eclipse.org', 1883) do |c|
      c.publish('augustoalbertoni/teste', 'L')
    end
    redirect_to root_url
  end

  def mode_off
    MQTT::Client.connect('iot.eclipse.org', 1883) do |c|
      c.publish('augustoalbertoni/teste', 'D')
    end
    redirect_to root_url
  end

end