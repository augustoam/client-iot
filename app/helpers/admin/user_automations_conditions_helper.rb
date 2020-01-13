module Admin::UserAutomationsConditionsHelper
  def admin_automacao_group_condicao_form_path(automacao_group, automacao_group_condicao)
    if automacao_group_condicao.new_record?
      admin_automacao_group_automacoes_group_condicoes_path(automacao_group)
    else
      admin_automacao_group_condicao_path(automacao_group_condicao)
    end
  end

  def tipo_condicao_keys
     UserAutomationCondition.tipo_condicaos.keys.collect{|t| [t_enum(UserAutomationCondition, "tipo_condicao", t), t] }
  end

end
