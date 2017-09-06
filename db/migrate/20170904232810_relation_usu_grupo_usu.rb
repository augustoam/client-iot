class RelationUsuGrupoUsu < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :usuarios, :grupos_usuarios
  end
end
