class CreateGroupAutomationActions < ActiveRecord::Migration[5.1]
  def change
    create_table :group_automation_actions do |t|
      t.integer :type_action
      t.decimal :delay_time
      t.integer :run_automation_id
      t.integer :group_automation_id
      t.integer :turn_on_off_automation_id
      t.integer :room_device_id
      t.integer :control_command_id
      t.integer :turn_on_off
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
