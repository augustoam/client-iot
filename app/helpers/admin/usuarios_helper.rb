module Admin::UsuariosHelper
  def admin_usuario_form_path(grupo, usuario)
    if usuario.new_record?
      admin_grupo_usuarios_path(grupo)
    else
      admin_grupo_usuario_path(grupo, usuario)
    end
  end
end
