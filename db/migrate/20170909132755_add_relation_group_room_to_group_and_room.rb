class AddRelationGroupRoomToGroupAndRoom < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :group_rooms, :groups
    add_foreign_key :group_rooms, :rooms
  end
end
