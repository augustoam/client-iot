class AddControleComponenteToComponentes < ActiveRecord::Migration[5.1]
  def change
    add_reference :componentes, :controles_componentes, foreign_key: true
  end
end
