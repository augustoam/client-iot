class AddIconAmbiente < ActiveRecord::Migration[5.1]
  def change
    add_column :ambientes, :icone, :string
  end
end
