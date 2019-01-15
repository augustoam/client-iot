class ComponentesPropriedades < ActiveRecord::Migration[5.1]
  def change
    create_table :componentes_propriedades do |t|
      t.string :descricao
      t.string :id_propriedade
      t.integer :componente_id
      t.timestamps
    end
  end
end
