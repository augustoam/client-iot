module Admin::GroupRoomsHelper
  def admin_group_room_form_path(group, group_room)
    if group_room.new_record?
      admin_group_group_rooms_path(group)
    else
      admin_group_room_path(group_room)
    end
  end
end
