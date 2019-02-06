class AddTopicoAutomacaoGrupo < ActiveRecord::Migration[5.1]
  def change
    add_column :automacoes_grupo, :topico_complete_manually, :string
  end
end
