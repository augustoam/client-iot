class LogComponentes < ActiveRecord::Migration[5.1]
  def change
  	create_table :log_componentes do |t|
  		t.integer :grupo_id
      t.integer :usuario_id
      t.integer :componente_id
      t.string :comando
      t.datetime :dt_criacao, default: DateTime.now
  	end
  end
end
