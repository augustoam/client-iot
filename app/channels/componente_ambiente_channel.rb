class RoomDeviceChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'room_device_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def estado(data)
    ActionCable.server.broadcast 'room_device_channel', room_device: data['room_device']
  end
end
