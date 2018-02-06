class AddReferenceFabricanteToControle < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :controles, :fabricantes
  end
end
