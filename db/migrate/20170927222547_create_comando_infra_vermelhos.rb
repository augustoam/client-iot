class CreateComandoInfraVermelhos < ActiveRecord::Migration[5.1]
  def change
    create_table :comandos_infra_vermelhos do |t|
      t.integer :controle_id
      t.string :comando
      t.string :codigo

      t.timestamps
    end
  end
end
