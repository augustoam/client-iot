class MqttSubscribeJob < ApplicationJob
  require 'rubygems'
  require 'mqtt'

  queue_as :critical

  def perform(*args)
    debugger
    puts args
    topicos = []

    DeviceRoom.all.each do |_device_room|
    #  topicos.push(_device_room.topico).split(',')         unless topicos.include? _device_room.topico
      topicos.push(_device_room.topico_info1).split(',')   unless topicos.include? _device_room.topico_info1
      topicos.push(_device_room.topico_info2).split(',')   unless topicos.include? _device_room.topico_info2
      topicos.push(_device_room.topico_info3).split(',')   unless topicos.include? _device_room.topico_info3
      topicos.push(_device_room.topico_online).split(',')  unless topicos.include? _device_room.topico_online
      topicos.push(_device_room.topico_state).split(',')   unless topicos.include? _device_room.topico_state
      topicos.push(_device_room.topico_power).split(',')   unless topicos.include? _device_room.topico_power
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
            devices_rooms = DeviceRoom.where(topico_info1: topic)
            if devices_rooms.present?
              devices_rooms.each do |device_room|
                puts device_room.descricao + ' - ' + message
                device_room.update!(info1: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do device room')
            end
          end
          if topic.include? 'INFO2' then
            devices_rooms = DeviceRoom.where(topico_info2: topic)
            if devices_rooms.present?
              devices_rooms.each do |device_room|
                puts device_room.descricao + ' - ' + message
                device_room.update!(info2: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do device room')
            end
          end
          if topic.include? 'INFO3' then
            devices_rooms = DeviceRoom.where(topico_info3: topic)
            if devices_rooms.present?
              devices_rooms.each do |device_room|
                puts device_room.descricao + ' - ' + message
                device_room.update!(info3: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do device room')
            end
          end
          if topic.include? 'RESULT' then
            devices_rooms = DeviceRoom.where(topico_result: topic)
            if devices_rooms.present?
              devices_rooms.each do |device_room|
                puts device_room.descricao + ' - ' + message
                device_room.update!(result: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do device room')
            end
          end
          if topic.include? 'STATE' then
            devices_rooms = DeviceRoom.where(topico_state: topic)
            if devices_rooms.present?
              devices_rooms.each do |device_room|
                puts device_room.descricao + ' - ' + message
                device_room.update!(state: message)
              end
            else
              Rails.logger.error('Erro no atualizar estado do device room')
            end
          end
          if topic.include? 'POWER' then
            devices_rooms = DeviceRoom.where(topico_power: topic)
            if devices_rooms.present?
              devices_rooms.each do |device_room|
                power = false
                power = true if message.upcase.include? 'ON'
                puts device_room.descricao + ' - ' + message
                device_room.update!(power: power)
              end
            else
              Rails.logger.error('Erro no atualizar estado do device room')
            end
          end
          if topic.include? 'LWT' then
            devices_rooms = DeviceRoom.where(topico_online: topic)
            if devices_rooms.present?
              devices_rooms.each do |device_room|
                online = false
                online = true if message.upcase.include? 'ONLINE'
                puts device_room.descricao + ' - ' + message
                device_room.update!(onlline: online)
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
