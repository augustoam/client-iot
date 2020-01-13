module Admin::RoomsGroupHelper
  def admin_room_group_form_path(group, room_group)
    if room_group.new_record?
      admin_group_rooms_group_path(group)
    else
      admin_room_group_path(room_group)
    end
  end
end
