module Admin::ComponentesHelper
  def admin_componente_form_path(ambiente, componente)
    if componente.new_record?
      admin_ambiente_componentes_path(ambiente)
    else
      admin_componente_path(componente)
    end
  end
end
