class AddRelationRoomDeviceToRoomAndDevice < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :room_devices, :group_rooms
    add_foreign_key :room_devices, :controls
  end
end
