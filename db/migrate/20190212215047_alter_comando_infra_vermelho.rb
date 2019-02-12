class AlterComandoInfraVermelho < ActiveRecord::Migration[5.1]
  def change
    rename_table :comandos_infra_vermelhos, :controle_comandos
    add_foreign_key :automacoes_grupo_acoes, :controle_comandos
    add_foreign_key :automacoes_grupo_condicoes, :controle_comandos
  end
end
