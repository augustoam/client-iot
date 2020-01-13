class AddRelationControlToDevice < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :controls, :devices
  end
end
