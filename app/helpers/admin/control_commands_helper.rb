module Admin::ControlCommandsHelper
  def admin_control_command_form_path(control, control_command)
    if control_command.new_record?
      admin_control_control_commands_path(control)
    else
      admin_control_command_path(control_command)
    end
  end

  def control_commands
    ControlCommand.all
  end
end
