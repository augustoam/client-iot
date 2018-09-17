class RemoveFksComponentes < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :componentes, column: :controle_id
    remove_foreign_key :componentes, column: :layout_controle_id
    remove_column :componentes, :controle_id
    remove_column :componentes, :fabricante_id
    remove_column :componentes, :layout_controle_id
  end
end
