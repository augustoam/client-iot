class CreateAmbientes < ActiveRecord::Migration[5.1]
  def change
    create_table :ambientes do |t|
      t.string :nome
      t.integer :grupo_id

      t.timestamps
    end
  end
end
