class ComponentesController < ApplicationController
  before_action :set_ambiente, only: [:index, :new, :create]
  before_action :set_componente, only: [:show, :edit, :update, :destroy]

  def index
    @componentes = @ambiente.componentes.all.order(:id)
  end

  def show
  end

  def new
    @componente = Componente.new
  end

  def edit
  end

  def create
    @componente = Componente.new(componente_params)

    respond_to do |format|
      if @componente.save
        format.html { redirect_to @componente, notice: 'Componente was successfully created.' }
        format.json { render :show, status: :created, location: @componente }
      else
        format.html { render :new }
        format.json { render json: @componente.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @componente.update(componente_params)
        format.html { redirect_to @componente, notice: 'Componente was successfully updated.' }
        format.json { render :show, status: :ok, location: @componente }
      else
        format.html { render :edit }
        format.json { render json: @componente.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @componente.destroy
    respond_to do |format|
      format.html { redirect_to componentes_url, notice: 'Componente was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_componente
      @componente = Componente.find(params[:id])
    end

    def set_ambiente
      @ambiente = Ambiente.find(params[:ambiente_id])
    end

    def componente_params
      params.require(:componente).permit(:descricao, :topico, :ambiente_id)
    end
end
