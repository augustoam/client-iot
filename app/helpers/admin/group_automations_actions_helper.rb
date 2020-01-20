module Admin::GroupAutomationsActionsHelper
  def admin_group_automation_action_form_path(group_automation, group_automation_action)
    if group_automation_action.new_record?
      admin_group_automation_group_automation_actions_path(group_automation)
    else
      admin_group_automation_action_path(group_automation_action)
    end
  end

  def type_action_keys
     GroupAutomationAction.type_actions.keys.collect{|t| [t_enum(GroupAutomationAction, "type_action", t), t] }
  end
end
