class CreateControlLayouts < ActiveRecord::Migration[5.1]
  def change
    create_table :control_layouts do |t|
      t.string :name, limit: 255
      t.text :obs
      t.string :type_name
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
