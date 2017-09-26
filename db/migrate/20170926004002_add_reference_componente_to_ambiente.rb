class AddReferenceComponenteToAmbiente < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :componentes, :ambientes
  end
end
