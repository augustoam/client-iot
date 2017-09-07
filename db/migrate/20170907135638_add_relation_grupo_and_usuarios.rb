class AddRelationGrupoAndUsuarios < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :grupos_usuarios, :usuarios
    add_foreign_key :grupos_usuarios, :grupos
  end
end
