class AddSchedulesGrupo < ActiveRecord::Migration[5.1]
  def change
    add_column :automacoes_grupo_condicoes, :schedule_cron, :string
  end
end
