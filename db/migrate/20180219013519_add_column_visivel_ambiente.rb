class AddColumnVisivelAmbiente < ActiveRecord::Migration[5.1]
  def change
    add_column :ambientes, :visivel, :boolean, default: true
  end
end
