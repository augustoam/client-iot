module Admin::UserAutomationsActionsHelper
  def admin_automacao_group_acao_form_path(automacao_group, automacao_group_acao)
    if automacao_group_acao.new_record?
      admin_automacao_group_automacoes_group_acoes_path(automacao_group)
    else
      admin_automacao_group_acao_path(automacao_group_acao)
    end
  end

  def tipo_acao_keys
     AutomacaoGroupAcao.tipo_acaos.keys.collect{|t| [t_enum(AutomacaoGroupAcao, "tipo_acao", t), t] }
  end
end
