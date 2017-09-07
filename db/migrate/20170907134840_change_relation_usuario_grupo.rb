class ChangeRelationUsuarioGrupo < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :usuarios, :grupos_usuarios
    remove_column :usuarios, :grupo_usuario_id, :integer
    remove_column :grupos_usuarios, :nome, :string
    add_column :grupos_usuarios, :grupo_id, :integer
    add_column :grupos_usuarios, :usuario_id, :integer
  end
end
