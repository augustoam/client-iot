class AddRelationRoomDeviceToRoomAndDevice < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :room_devices, :rooms
    add_foreign_key :room_devices, :devices
  end
end
