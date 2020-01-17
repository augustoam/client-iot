class AddRelationGroupAutomation < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :group_automations, :user_groups
  end
end
