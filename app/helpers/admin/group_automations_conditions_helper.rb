module Admin::GroupAutomationsConditionsHelper
  def admin_group_automation_condition_form_path(group_automation, group_automation_condition)
    if group_automation_condition.new_record?
      admin_group_automation_group_automation_conditions_path(group_automation)
    else
      admin_group_automation_condition_path(group_automation_condition)
    end
  end

  def tipo_condicao_keys
     GroupAutomationCondition.tipo_condicaos.keys.collect{|t| [t_enum(GroupAutomationCondition, "tipo_condicao", t), t] }
  end

end
