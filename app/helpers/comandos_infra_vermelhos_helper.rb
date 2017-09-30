module ComandosInfraVermelhosHelper
  def topico_comando(acao, componente)
    componente.comandos_infra_vermelhos.find_by(comando: acao).topico
  end

  def estado_componente(componente)
     if componente.estado
       'off'
     else
       'on'
     end
  end
end
