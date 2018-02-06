class CreateAmbientesComponentes < ActiveRecord::Migration[5.1]
  def change
    create_table :componentes_ambiente do |t|
      t.integer :ambiente_id
      t.integer :componente_id
      t.string :topico
      t.boolean :estado, default: false
      t.text :descricao
      t.text :identificador_componente
      t.timestamps
    end
  end
end
