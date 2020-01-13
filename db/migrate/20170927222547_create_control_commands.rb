class CreateControlCommands < ActiveRecord::Migration[5.1]
  def change
    create_table :control_commands do |t|
      t.integer :control_id
      t.string :command
      t.string :code
      t.boolean :active, default: true
      
      t.timestamps
    end
  end
end
