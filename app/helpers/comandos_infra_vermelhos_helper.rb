module ComandosInfraVermelhosHelper
  def topico_comando(acao, device)
    comando = device.comandos_infra_vermelhos.find_by(comando: acao)
    comando.topico if comando.present?
  end

  def estado_device(device)
     if device.estado
       'off'
     else
       'on'
     end
  end
end
