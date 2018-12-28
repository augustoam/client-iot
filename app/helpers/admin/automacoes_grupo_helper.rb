module Admin::AutomacoesGrupoHelper
  def admin_automacao_grupo_form_path(grupo, automacao_grupo)
    if automacao_grupo.new_record?
      admin_grupo_automacoes_grupo_path(grupo)
    else
      admin_automacao_grupo_path(automacao_grupo)
    end
  end
end
