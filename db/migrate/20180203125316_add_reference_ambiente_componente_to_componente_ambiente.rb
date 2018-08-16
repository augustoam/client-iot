class AddReferenceAmbienteComponenteToComponenteAmbiente < ActiveRecord::Migration[5.1]
  def change
    # add_foreign_key :componentes_ambiente, :ambientes_grupo
    add_foreign_key :componentes_ambiente, :componentes
  end
end
