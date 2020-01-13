class AddRelationControlToManufacturer < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :controls, :manufacturers
    add_foreign_key :controls, :control_layouts
  end
end
