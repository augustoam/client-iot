class RelationAmbenteGrupo < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :ambientes, :grupos
  end
end
