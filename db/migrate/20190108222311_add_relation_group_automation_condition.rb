class AddRelationGroupAutomationCondition < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :group_automation_conditions, :group_automations
    add_foreign_key :group_automation_conditions, :room_devices
    add_foreign_key :group_automation_conditions, :control_commands
  end
end
