module ControlLayoutsHelper
  def define_acao(acao, room_device)
    comando = room_device.control.comandos_infra_vermelhos.find_by(comando: acao)
    comando.codigo.to_s if comando.present?
  end
end
