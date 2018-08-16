class CreateAmbientesRoot < ActiveRecord::Migration[5.1]
  def change
    create_table :ambientes do |t|
      t.string :descricao
      t.string :icone
      t.string :obs
      t.timestamps
    end
  end
end
