class AutomacoesGrupoAcoes < ActiveRecord::Migration[5.1]
  def change
    create_table :automacoes_grupo_acoes do |t|
      t.boolean :run_automation
      t.boolean :turn_on_off_automation
      t.boolean :send_notification
      t.boolean :delay
      t.decimal :delay_time
      t.integer :run_automacao_id
      t.integer :turn_on_off_automation_id
      t.integer :automacao_grupo_id
      t.integer :componente_ambiente_id
      t.timestamps
    end
  end
end
