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
      c.publish('augusto.albertoni@gmail.com/room/lights', 'on')
    end
    redirect_to root_url
  end

  def mode_off
    MQTT::Client.connect('iot.eclipse.org', 1883) do |c|
      c.publish('augusto.albertoni@gmail.com/room/lights', 'off')
    end
    redirect_to root_url
  end

  def console
    @grupos_usuario = GrupoUsuario.where(usuario_id: current_usuario)
  end

end
