class AddReferencesToComponenteAmbiente < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :componentes_ambiente, :ambientes_grupo
    add_foreign_key :ambientes_grupo, :ambientes
  end
end
