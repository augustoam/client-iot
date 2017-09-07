class UsuarioConfirmation < ActiveRecord::Migration[5.1]
  def change
    remove_column :usuarios, :unconfirmed_email
    add_index :usuarios, :confirmation_token, :unique => true
    Usuario.update_all({:confirmed_at => DateTime.now, :confirmation_sent_at => DateTime.now})
  end
end
