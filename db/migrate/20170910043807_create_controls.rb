class CreateControls < ActiveRecord::Migration[5.1]
  def change
    create_table :controls do |t|
      t.string :name, limit: 255
      t.text :obs
      t.integer :manufacturer_id
      t.integer :control_layout_id
      t.integer :device_id
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
