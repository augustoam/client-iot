module Admin::DevicesRoomHelper
  def admin_device_room_form_path(room_group, device)
    if device.new_record?
      admin_room_group_devices_room_path(room_group)
    else
      admin_device_room_path(device)
    end
  end

  def devices_rooms(rooms_group)
    DeviceRoom.where(room_group: rooms_group).to_a
  end
end
