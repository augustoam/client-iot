module ControlLayoutsHelper
  def define_acao(acao, device_room)
    comando = device_room.control.comandos_infra_vermelhos.find_by(comando: acao)
    comando.codigo.to_s if comando.present?
  end
end
