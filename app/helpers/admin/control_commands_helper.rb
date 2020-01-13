module Admin::ControlCommandsHelper
  def admin_control_comando_form_path(control, control_comando)
    if control_comando.new_record?
      admin_control_control_comandos_path(control)
    else
      admin_control_comando_path(control_comando)
    end
  end

  def control_comandos
    ControlComando.all
  end
end
