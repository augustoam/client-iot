class AddRelationControlCommandToControl < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :control_commands, :controls
  end
end
