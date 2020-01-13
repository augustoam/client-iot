class AddRelationNotificationTokensToUser < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :notification_tokens, :users
  end
end
