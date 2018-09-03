class ComponentesAmbienteController < ApplicationController
  include MqttBroker
  before_action :set_ambiente

  def index
    @componentes_ambiente = @ambiente_grupo.componentes_ambiente.all.order(:id)
  end

  def show; end

  private

  def set_ambiente
    @ambiente_grupo = AmbienteGrupo.find(params[:ambiente_grupo_id])
  end
end
