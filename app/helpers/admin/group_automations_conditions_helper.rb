module Admin::GroupAutomationsConditionsHelper
  def admin_group_automation_condition_form_path(group_automation, group_automation_condition)
    if group_automation_condition.new_record?
      admin_group_automation_group_automation_conditions_path(group_automation)
    else
      admin_group_automation_condition_path(group_automation_condition)
    end
  end

  def type_condition_keys
    GroupAutomationCondition.type_conditions.keys.collect{|t| [t_enum(GroupAutomationCondition, "type_condition", t), t] }
  end

end
