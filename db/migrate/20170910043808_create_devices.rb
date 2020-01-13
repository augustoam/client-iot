class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :name, limit: 255
      t.string :model, limit: 255
      t.string :url_icon
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
