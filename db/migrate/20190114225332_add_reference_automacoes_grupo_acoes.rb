class AddReferenceAutomacoesGrupoAcoes < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :automacoes_grupo_acoes, :componentes_ambiente
    add_foreign_key :automacoes_grupo_acoes, :automacoes_grupo
    add_foreign_key :automacoes_grupo_acoes, :automacoes_grupo, column: :run_automacao_id
    add_foreign_key :automacoes_grupo_acoes, :automacoes_grupo, column: :turn_on_off_automation_id
    add_foreign_key :automacoes_grupo_acoes, :componentes_propriedades
    add_foreign_key :automacoes_grupo_condicoes, :componentes_propriedades
  end
end
