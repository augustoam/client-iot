module Admin::AutomacoesGrupoAcoesHelper
  def admin_automacao_grupo_acao_form_path(automacao_grupo, automacao_grupo_acao)
    if automacao_grupo_acao.new_record?
      admin_automacao_grupo_automacoes_grupo_acoes_path(automacao_grupo)
    else
      admin_automacao_grupo_acao_path(automacao_grupo_acao)
    end
  end
end
