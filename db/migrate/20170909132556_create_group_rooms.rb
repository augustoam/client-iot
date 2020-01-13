class CreateGroupRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :group_rooms do |t|
      t.string :name, limit: 255
      t.integer :group_id
      t.integer :room_id
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
