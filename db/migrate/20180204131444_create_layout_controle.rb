class CreateLayoutControle < ActiveRecord::Migration[5.1]
  def change
    create_table :layout_controles do |t|
      t.string :descricao
      t.string :obs
      t.string :tipo_layout
      t.timestamps
    end
  end
end
