module ComandosInfraVermelhosHelper
  def topico_comando(acao, componente)
    componente.comandos_infra_vermelhos.where(comando: acao).first.topico
  end

  def estado_componente(componente)
     if componente.estado
       'off'
     else
       'true'
     end
  end
end
