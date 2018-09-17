class AddColumnsToControles < ActiveRecord::Migration[5.1]
  def change
    add_column :controles, :layout_controle_id, :integer
    add_column :controles, :componente_id, :integer
    add_foreign_key :controles, :layout_controles
    add_foreign_key :controles, :componentes
  end
end
