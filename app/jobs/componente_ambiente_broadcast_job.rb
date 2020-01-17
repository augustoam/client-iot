class RoomDeviceBroadcastJob < ApplicationJob
  queue_as :critical

  def perform(room_device)
    ActionCable.server.broadcast 'room_device_channel', room_device: render_room_device(room_device)
  end

  private

  def render_room_device(room_device)
    ApplicationController.renderer.render(partial: "room_devices/#{room_device.device.control_layout.name.downcase}",
                                          locals: { room_device: room_device })
  end
end
