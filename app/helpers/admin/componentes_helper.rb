module Admin::ComponentesHelper
  def admin_componente_form_path(ambiente, componente)
    if componente.new_record?
      admin_grupo_ambiente_componentes_path(ambiente.grupo, ambiente)
    else
      admin_grupo_ambiente_componente_path(componente.ambiente.grupo, componente.ambiente, componente)
    end
  end
end
