class MqttSubscribeJob < ApplicationJob
  require 'rubygems'
  require 'mqtt'

  queue_as :critical

  def perform(*args)
    debugger
    puts args
    topicos = []

    RoomDevice.all.each do |_room_device|
    #  topicos.push(_room_device.topico).split(',')         unless topicos.include? _room_device.topico
      topicos.push(_room_device.topico_info1).split(',')   unless topicos.include? _room_device.topico_info1
      topicos.push(_room_device.topico_info2).split(',')   unless topicos.include? _room_device.topico_info2
      topicos.push(_room_device.topico_info3).split(',')   unless topicos.include? _room_device.topico_info3
      topicos.push(_room_device.topico_online).split(',')  unless topicos.include? _room_device.topico_online
      topicos.push(_room_device.topico_state).split(',')   unless topicos.include? _room_device.topico_state
      topicos.push(_room_device.topico_power).split(',')   unless topicos.include? _room_device.topico_power
    end

    uri = URI.parse ENV['CLOUDMQTT_URL']
      conn_opts = {
        remote_host: uri.host,
        remote_port: uri.port,
        username: uri.user,
        password: uri.password,
      }

    Thread.new do
      MQTT::Client.connect(conn_opts) do |_client|
        _client.subscribe(topicos)

        _client.get do |topic, message|
          if topic.include? 'INFO1' then
            room_devicess = RoomDevice.where(topico_info1: topic)
            if room_devicess.present?
              room_devicess.each do |room_device|
                puts room_device.name + ' - ' + message
                room_device.update!(info1: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do device room')
            end
          end
          if topic.include? 'INFO2' then
            room_devicess = RoomDevice.where(topico_info2: topic)
            if room_devicess.present?
              room_devicess.each do |room_device|
                puts room_device.name + ' - ' + message
                room_device.update!(info2: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do device room')
            end
          end
          if topic.include? 'INFO3' then
            room_devicess = RoomDevice.where(topico_info3: topic)
            if room_devicess.present?
              room_devicess.each do |room_device|
                puts room_device.name + ' - ' + message
                room_device.update!(info3: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do device room')
            end
          end
          if topic.include? 'RESULT' then
            room_devicess = RoomDevice.where(topico_result: topic)
            if room_devicess.present?
              room_devicess.each do |room_device|
                puts room_device.name + ' - ' + message
                room_device.update!(result: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do device room')
            end
          end
          if topic.include? 'STATE' then
            room_devicess = RoomDevice.where(topico_state: topic)
            if room_devicess.present?
              room_devicess.each do |room_device|
                puts room_device.name + ' - ' + message
                room_device.update!(state: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do device room')
            end
          end
          if topic.include? 'POWER' then
            room_devicess = RoomDevice.where(topico_power: topic)
            if room_devicess.present?
              room_devicess.each do |room_device|
                power = false
                power = true if message.upcase.include? 'ON'
                puts room_device.name + ' - ' + message
                room_device.update!(power: power)
              end
            else
              Rails.logger.error('Erro no atualizar estado do device room')
            end
          end
          if topic.include? 'LWT' then
            room_devicess = RoomDevice.where(topico_online: topic)
            if room_devicess.present?
              room_devicess.each do |room_device|
                online = false
                online = true if message.upcase.include? 'ONLINE'
                puts room_device.name + ' - ' + message
                room_device.update!(onlline: online)
              end
            else
              Rails.logger.error('Erro no atualizar estado do device room')
            end
          end
        end
      end
    end
  end
end
