class AddColumnValorComponenteAmbiente < ActiveRecord::Migration[5.1]
  def change
    add_column :componentes_ambiente, :valor, :string
  end
end
