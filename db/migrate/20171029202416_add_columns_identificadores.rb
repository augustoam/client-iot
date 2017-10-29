class AddColumnsIdentificadores < ActiveRecord::Migration[5.1]
  def change
    add_column :componentes, :identificador_componente, :string
  end
end
