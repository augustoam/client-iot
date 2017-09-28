module Admin::AmbientesHelper
  def admin_ambiente_form_path(grupo, ambiente)
    if ambiente.new_record?
      admin_grupo_ambientes_path(grupo)
    else
      admin_ambiente_path(ambiente)
    end
  end
end
