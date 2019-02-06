class AddOperadorAutomacaoGrupo < ActiveRecord::Migration[5.1]
  def change
    add_column :automacoes_grupo, :operador_condicao, :integer
  end
end
