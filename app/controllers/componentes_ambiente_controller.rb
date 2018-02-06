class ComponentesAmbienteController < ApplicationController
  include MqttBroker
  before_action :set_ambiente

  def index
    @componentes_ambiente = @ambiente.componentes_ambiente.all.order(:id)
  end

  def show; end

  private

  def set_ambiente
    @ambiente = Ambiente.find(params[:ambiente_id])
  end
end
