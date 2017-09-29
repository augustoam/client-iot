class ComandosInfraVermelhosController < ApplicationController
  before_action :set_componente, only: [:index]

  def index
    @comandos_infra_vermelhos = @componente.comandos_infra_vermelhos.all
  end

  private

    def set_componente
      @componente = Componente.find(params[:componente_id])
    end
end
