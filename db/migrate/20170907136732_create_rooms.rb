class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :name, limit: 255
      t.string :obs
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
