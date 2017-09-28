class CreateComandoInfraVermelhos < ActiveRecord::Migration[5.1]
  def change
    create_table :comandos_infra_vermelhos do |t|
      t.integer :componente_id
      t.string :topico
      t.string :comando
      t.string :html

      t.timestamps
    end
  end
end
