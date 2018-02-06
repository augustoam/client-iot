module Admin::ComandosInfraVermelhosHelper
  def admin_comando_infra_vermelho_form_path(controle, comando_infra_vermelho)
    if comando_infra_vermelho.new_record?
      admin_controle_comandos_infra_vermelhos_path(controle)
    else
      admin_comando_infra_vermelho_path(comando_infra_vermelho)
    end
  end
end
