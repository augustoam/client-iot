class AddRelationGroupAutomationAction < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :group_automation_actions, :group_automations
    add_foreign_key :group_automation_actions, :room_devices
    add_foreign_key :group_automation_actions, :control_commands
    add_foreign_key :group_automation_actions, :group_automations, column: :run_automation_id
    add_foreign_key :group_automation_actions, :group_automations, column: :turn_on_off_automation_id
  end
end
