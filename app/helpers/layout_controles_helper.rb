module LayoutControlesHelper
  def define_acao(acao, componente_ambiente)
    comando = componente_ambiente.controle.comandos_infra_vermelhos.find_by(comando: acao)
    comando.codigo.to_s if comando.present?
  end
end
