class RelationAmbenteGrupo < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :ambientes_grupo, :grupos
  end
end
