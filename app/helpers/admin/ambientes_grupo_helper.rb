module Admin::AmbientesGrupoHelper
  def admin_ambiente_grupo_form_path(grupo, ambiente_grupo)
    if ambiente_grupo.new_record?
      admin_grupo_ambientes_grupo_path(grupo)
    else
      admin_ambiente_grupo_path(ambiente_grupo)
    end
  end
end
