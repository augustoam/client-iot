class GruposUsuarios < ActiveRecord::Migration[5.1]
  def change
  	create_table :grupos_usuarios do |t|
  		t.integer :grupo_id
      t.integer :usuario_id
      t.timestamps
  	end
  end
end
