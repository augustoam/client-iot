class CreateRoomDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :room_devices do |t|
      t.string :name, limit: 255
      t.integer :room_id
      t.integer :device_id
      t.string :topic_id
      t.string :sensor_value
      t.boolean :power
      t.boolean :online
      t.string :result
      t.string :state
      t.string :info1
      t.string :info2
      t.string :info3
      t.string :topic_info1
      t.string :topic_info2
      t.string :topic_info3
      t.string :topic_power
      t.string :topic_online
      t.string :topic_result
      t.string :topic_publish
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
