class AddColumnsUsuario < ActiveRecord::Migration[5.1]
  def change
    change_table :usuarios do |t|
        t.integer :grupo_usuario_id
        t.boolean :admin, default: false
    end
  end
end