class AddReferenceLayoutControleToComponente < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :componentes, :layout_controles
  end
end
