module Admin::ComponentesAmbienteHelper
  def admin_componente_ambiente_form_path(ambiente_grupo, componente)
    if componente.new_record?
      admin_ambiente_grupo_componentes_ambiente_path(ambiente_grupo)
    else
      admin_componente_ambiente_path(componente)
    end
  end

  def componentes_ambientes(ambientes_grupo)
    ComponenteAmbiente.where(ambiente_grupo: ambientes_grupo)
  end
end
