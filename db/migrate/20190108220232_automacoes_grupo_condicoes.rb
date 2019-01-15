class AutomacoesGrupoCondicoes < ActiveRecord::Migration[5.1]
  def change
    create_table :automacoes_grupo_condicoes do |t|
      t.boolean :manual
      t.boolean :timer
      t.string :repeat
      t.datetime :turn_on
      t.integer :automacao_grupo_id
      t.integer :componente_ambiente_id
      t.timestamps
    end
  end
end
