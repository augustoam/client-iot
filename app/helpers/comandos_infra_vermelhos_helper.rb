module ComandosInfraVermelhosHelper
  def topico_comando(acao, componente)
    comando = componente.comandos_infra_vermelhos.find_by(comando: acao)
    comando.topico if comando.present?
  end

  def estado_componente(componente)
     if componente.estado
       'off'
     else
       'on'
     end
  end
end
