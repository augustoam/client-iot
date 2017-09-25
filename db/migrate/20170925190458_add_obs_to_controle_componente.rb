class AddObsToControleComponente < ActiveRecord::Migration[5.1]
  def change
    add_column :controles_componentes, :obs, :text
  end
end
