class CreateAmbientes < ActiveRecord::Migration[5.1]
  def change
    create_table :ambientes_grupo do |t|
      t.string :nome
      t.integer :grupo_id
      t.integer :ambiente_id
      t.string :icone
      t.boolean :visivel, default: true

      t.timestamps
    end
  end
end
