class CreateTokenNotificacaoMobile < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens_notificacao_mobile do |t|
      t.string :token
      t.integer :usuario_id
      t.timestamps
    end
  end
end
