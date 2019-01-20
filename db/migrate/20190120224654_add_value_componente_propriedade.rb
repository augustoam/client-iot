class AddValueComponentePropriedade < ActiveRecord::Migration[5.1]
  def change
    add_column :automacoes_grupo_condicoes, :value_set, :string
  end
end
