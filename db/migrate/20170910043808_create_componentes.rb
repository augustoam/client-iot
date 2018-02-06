class CreateComponentes < ActiveRecord::Migration[5.1]
  def change
    create_table :componentes do |t|
      t.string :descricao
      t.string :modelo
      t.integer :controle_id
      t.integer :fabricante_id
      t.integer :layout_controle_id
      t.timestamps
    end
  end
end
