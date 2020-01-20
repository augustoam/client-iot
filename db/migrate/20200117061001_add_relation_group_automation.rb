class AddRelationGroupAutomation < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :group_automations, :groups
  end
end
