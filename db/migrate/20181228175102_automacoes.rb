class Automacoes < ActiveRecord::Migration[5.1]
  def change
    create_table :automacoes_grupo do |t|
      t.integer :grupo_id
      t.integer :tipo
      t.string :descricao, null: false, default: ""
      t.boolean :ativo, default: true
      t.timestamps
    end
  end
end
