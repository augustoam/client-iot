class CreateFabricante < ActiveRecord::Migration[5.1]
  def change
    create_table :fabricantes do |t|
      t.string :descricao
      t.string :obs
      t.timestamps
    end
  end
end
