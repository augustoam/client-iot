class AutomacoesGrupoAcoes < ActiveRecord::Migration[5.1]
  def change
    create_table :automacoes_grupo_acoes do |t|
      t.integer :tipo_acao
      t.decimal :delay_time
      t.integer :run_automacao_id
      t.integer :turn_on_off_automation_id
      t.integer :automacao_grupo_id
      t.integer :componente_ambiente_id
      t.integer :controle_comando_id
      t.timestamps
    end
  end
end
