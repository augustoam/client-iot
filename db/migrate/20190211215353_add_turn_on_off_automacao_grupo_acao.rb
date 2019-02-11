class AddTurnOnOffAutomacaoGrupoAcao < ActiveRecord::Migration[5.1]
  def change
    add_column :automacoes_grupo_acoes, :turn_on_off, :integer
  end
end
