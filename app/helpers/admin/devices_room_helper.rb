module Admin::DevicesRoomHelper
  def admin_room_device_form_path(group_room, device)
    if device.new_record?
      admin_group_room_room_devices_path(group_room)
    else
      admin_room_device_path(device)
    end
  end

  def room_devicess(group_rooms)
    RoomDevice.where(group_room: group_rooms).to_a
  end
end
