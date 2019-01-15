module Admin::ComponentesPropriedadesHelper
  def admin_componente_propriedade_form_path(componente, componente_propriedade)
    if componente_propriedade.new_record?
      admin_componente_componentes_propriedades_path(componente)
    else
      admin_componente_propriedade_path(componente_propriedade)
    end
  end
end
