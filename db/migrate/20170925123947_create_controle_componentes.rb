class CreateControleComponentes < ActiveRecord::Migration[5.1]
  def change
    create_table :controles do |t|
      t.string :descricao
      t.text :obs
      t.integer :fabricante_id
      t.timestamps
    end
  end
end
