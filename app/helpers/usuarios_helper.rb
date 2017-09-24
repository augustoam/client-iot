module UsuariosHelper
  def usuario_form_path(grupo)
    if grupo.new_record?
      grupo_usuarios_path(usuario.grupo)
    else
      grupo_usuario_path(grupo)
    end
  end

  def grupo_usuario(grupo, usuario)
    grupo.grupos_usuarios.find_by(usuario_id: usuario)
  end
end
