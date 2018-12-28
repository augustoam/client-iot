class AddColumnsComponenteAmbiente < ActiveRecord::Migration[5.1]
  def change
     add_column :componentes_ambiente, :power, :boolean
     add_column :componentes_ambiente, :result, :string
     add_column  :componentes_ambiente, :info1, :string
     add_column :componentes_ambiente, :info2, :string
     add_column  :componentes_ambiente, :info3, :string
     add_column :componentes_ambiente, :onlline, :boolean
     add_column :componentes_ambiente, :state, :string
  end
end
