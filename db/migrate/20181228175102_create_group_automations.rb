class CreateGroupAutomations < ActiveRecord::Migration[5.1]
  def change
    create_table :group_automations do |t|
      t.integer :user_group_id
      t.boolean :condition_operator
      t.string :name, limit: 255
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
