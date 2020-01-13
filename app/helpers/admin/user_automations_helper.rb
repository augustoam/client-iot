module Admin::UserAutomationsHelper
  def admin_automacao_group_form_path(group, automacao_group)
    if automacao_group.new_record?
      admin_group_automacoes_group_path(group)
    else
      admin_automacao_group_path(automacao_group)
    end
  end

  def automacoes_group(group)
    AutomacaoGroup.where(group: group)
  end
end
