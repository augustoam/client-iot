module Admin::UsuariosHelper
  def admin_usuario_form_path(usuario)
    debugger
    if usuario.new_record?
      admin_grupo_usuarios_path(usuario.grupo)
    else
      admin_grupo_usuario_path(usuario)
    end
  end
end
