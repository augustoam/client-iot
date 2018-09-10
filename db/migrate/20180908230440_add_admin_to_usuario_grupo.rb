class AddAdminToUsuarioGrupo < ActiveRecord::Migration[5.1]
  def change
    add_column :grupos_usuarios, :admin, :boolean, default: false
  end
end
