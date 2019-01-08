class AddRefAutomacoesGrupo < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :automacoes_grupo_condicoes, :automacoes_grupo
  end
end
