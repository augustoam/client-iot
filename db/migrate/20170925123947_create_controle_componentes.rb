class CreateControleComponentes < ActiveRecord::Migration[5.1]
  def change
    create_table :controles_componentes do |t|
      t.string :descricao
      t.text :obs
      t.timestamps
    end
  end

  def down
    remove_columns :controles_componentes, :descricao
    remove_columns :controles_componentes, :obs
    remove_columns :componentes, :controle_componente_id
  end
end
