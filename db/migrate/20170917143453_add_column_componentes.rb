class AddColumnComponentes < ActiveRecord::Migration[5.1]
  def change
    add_column :componentes, :estado, :boolean
  end
end
