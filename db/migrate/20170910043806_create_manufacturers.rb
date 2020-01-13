class CreateManufacturers < ActiveRecord::Migration[5.1]
  def change
    create_table :manufacturers do |t|
      t.string :name, limit: 255
      t.text :obs
      t.boolean :active, default: true
      
      t.timestamps
    end
  end
end
