module Admin::GroupAutomationsHelper
  def admin_group_automation_form_path(group, group_automation)
    if group_automation.new_record?
      admin_group_group_automations_path(group)
    else
      admin_group_automation_path(group_automation)
    end
  end

  def group_automations(group)
    GroupAutomation.where(group: group)
  end
end
