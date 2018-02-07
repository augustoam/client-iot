class AddColumnComandoUnicoToComponentes < ActiveRecord::Migration[5.1]
  def change
    add_column :componentes, :comando_unico, :boolean, default: false
  end
end
