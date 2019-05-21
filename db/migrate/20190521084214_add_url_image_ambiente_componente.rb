class AddUrlImageAmbienteComponente < ActiveRecord::Migration[5.1]
  def change
    add_column :ambientes, :url_icone, :string
    add_column :componentes, :url_icone, :string
  end
end
