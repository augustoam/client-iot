class DeviceRoomBroadcastJob < ApplicationJob
  queue_as :critical

  def perform(device_room)
    ActionCable.server.broadcast 'device_room_channel', device_room: render_device_room(device_room)
  end

  private

  def render_device_room(device_room)
    ApplicationController.renderer.render(partial: "devices_room/#{device_room.device.layout_control.descricao.downcase}",
                                          locals: { device_room: device_room })
  end
end
