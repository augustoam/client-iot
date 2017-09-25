class CreateControleComponentes < ActiveRecord::Migration[5.1]
  def change
    create_table :controles_componentes do |t|
      t.text :descricao

      t.timestamps

    end
    add_column :componentes, :controle_componente_id, :integer
  end

  def down
    remove_columns :controles_componentes, :descricao
    remove_columns :componentes, :controle_componente_id
  end
end
