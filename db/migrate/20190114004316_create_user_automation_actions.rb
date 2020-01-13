class CreateUserAutomationActions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_automation_actions do |t|
      t.integer :type
      t.decimal :delay_time
      t.integer :run_automation_id
      t.integer :user_automation_id
      t.integer :turn_on_off_automation_id
      t.integer :room_device_id
      t.integer :control_command_id
      t.boolean :turn_on_off
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
