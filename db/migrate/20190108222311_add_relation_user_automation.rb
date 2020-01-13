class AddRelationUserAutomation < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :user_automation_conditions, :user_automations
    add_foreign_key :user_automation_conditions, :room_devices
    add_foreign_key :user_automation_conditions, :control_commands
  end
end
