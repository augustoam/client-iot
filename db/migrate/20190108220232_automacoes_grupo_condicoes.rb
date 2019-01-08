class AutomacoesGrupoCondicoes < ActiveRecord::Migration[5.1]
  def change
    create_table :automacoes_grupo_condicoes do |t|
      t.boolean :manual
      t.boolean :timer
      t.decimal :repeat
      t.datetime :turn_on
      t.integer :automacao_grupo_id
      t.timestamps
    end
  end
end
