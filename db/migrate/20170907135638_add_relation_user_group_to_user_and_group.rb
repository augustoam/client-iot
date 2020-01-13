class AddRelationUserGroupToUserAndGroup < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :user_groups, :users
    add_foreign_key :user_groups, :groups
  end
end
