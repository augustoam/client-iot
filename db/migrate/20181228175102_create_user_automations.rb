class CreateUserAutomations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_automations do |t|
      t.integer :user_id
      t.boolean :condition_operator
      t.string :name, limit: 255
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
