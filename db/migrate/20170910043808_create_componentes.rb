class CreateComponentes < ActiveRecord::Migration[5.1]
  def change
    create_table :componentes do |t|
      t.string :descricao
      t.string :topico
      t.integer :ambiente_id

      t.timestamps
    end
  end
end