class AddReferenceComandoInfraVermelhoToComponente < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :comandos_infra_vermelhos, :controles
  end
end
