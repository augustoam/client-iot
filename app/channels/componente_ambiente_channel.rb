class DeviceRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'device_room_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def estado(data)
    ActionCable.server.broadcast 'device_room_channel', device_room: data['device_room']
  end
end
