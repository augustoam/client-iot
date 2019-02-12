module Admin::ControleComandosHelper
  def admin_controle_comando_form_path(controle, controle_comando)
    if controle_comando.new_record?
      admin_controle_controle_comandos_path(controle)
    else
      admin_controle_comando_path(controle_comando)
    end
  end

  def controle_comandos
    ControleComando.all
  end
end
