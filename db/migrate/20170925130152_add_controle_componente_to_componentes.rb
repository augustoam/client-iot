class AddControleComponenteToComponentes < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :componentes, :controles_componentes
  end
end
