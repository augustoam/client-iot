class AddIdentificadorComponentes < ActiveRecord::Migration[5.1]
  def change
    add_column :componentes, :identificador, :string, default: 'NENHUM'
  end
end
