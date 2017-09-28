module Admin::ComandosInfraVermelhosHelper
  def admin_comando_infra_vermelho_form_path(componente, comando_infra_vermelho)
    if comando_infra_vermelho.new_record?
      admin_componente_comandos_infra_vermelhos_path(componente)
    else
      admin_comando_infra_vermelho_path(comando_infra_vermelho)
    end
  end
end
