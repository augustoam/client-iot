class LayoutControlesController < ApplicationController
  before_action :set_componente, only: [:index]

  def index
    @layout_controle = @componente_ambiente.componente.layout_controle
  end

  private

  def set_componente
    @componente_ambiente = ComponenteAmbiente.find(params[:componente_ambiente_id])
  end
end
