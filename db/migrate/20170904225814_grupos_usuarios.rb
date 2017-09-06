class GruposUsuarios < ActiveRecord::Migration[5.1]
  def change
  	create_table :grupos_usuarios do |t|
  		t.string :nome, null: false
  		t.timestamps
  	end
  end
end
