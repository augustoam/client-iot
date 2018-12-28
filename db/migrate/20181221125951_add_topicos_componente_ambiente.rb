class AddTopicosComponenteAmbiente < ActiveRecord::Migration[5.1]
  def change
    add_column :componentes_ambiente, :topico_power, :string
    add_column :componentes_ambiente, :topico_result, :string
    add_column  :componentes_ambiente, :topico_info1, :string
    add_column :componentes_ambiente, :topico_info2, :string
    add_column  :componentes_ambiente, :topico_info3, :string
    add_column :componentes_ambiente, :topico_online, :string
    add_column :componentes_ambiente, :topico_state, :string
  end
end
