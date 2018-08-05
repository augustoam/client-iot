class AddReferenceTokenToUsuario < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :tokens_notificacao_mobile, :usuarios
    add_column :usuarios, :token, :string
  end
end
