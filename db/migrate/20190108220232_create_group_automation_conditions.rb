class CreateGroupAutomationConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :group_automation_conditions do |t|
      t.integer :group_automation_id
      t.string :repeat
      t.integer :type_condition
      t.integer :room_device_id
      t.integer :control_command_id
      t.datetime :turn_on
      t.string :value_set
      t.string :schedule_cron
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
