class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name, limit: 255
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
