class CreateLayoutControle < ActiveRecord::Migration[5.1]
  def change
    create_table :layout_controles do |t|
      t.string :descricao
      t.string :obs
      t.timestamps
    end
  end
end
