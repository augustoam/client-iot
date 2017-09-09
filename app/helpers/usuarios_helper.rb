module UsuariosHelper
  def usuario_form_path(grupo)
    if grupo.new_record?
      grupo_usuarios_path(usuario.grupo)
    else
      grupo_usuario_path(grupo)
    end
  end
end
