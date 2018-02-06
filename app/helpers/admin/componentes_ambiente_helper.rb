module Admin::ComponentesAmbienteHelper
  def admin_componente_ambiente_form_path(ambiente, componente)
    if componente.new_record?
      admin_ambiente_componentes_ambiente_path(ambiente)
    else
      admin_componente_ambiente_path(componente)
    end
  end
end
