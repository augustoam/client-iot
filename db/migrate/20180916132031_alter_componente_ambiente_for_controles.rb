class AlterComponenteAmbienteForControles < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :componentes_ambiente, column: :componente_id
    remove_column :componentes_ambiente, :componente_id
    add_column :componentes_ambiente, :controle_id, :integer
    add_foreign_key :componentes_ambiente, :controles
  end
end
