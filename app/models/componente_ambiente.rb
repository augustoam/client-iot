class ComponenteAmbiente < ApplicationRecord
  belongs_to :ambiente_grupo
  belongs_to :controle

  before_create :update_topicos

  validates :descricao, :identificador_componente, presence: true
  # after_save { ComponenteAmbienteBroadcastJob.perform_later self }
  def to_s
    descricao.to_s
  end

  def update_topicos
    self.topico_info1  = 'cmnd/' + self.identificador_componente + '/info1'
    self.topico_info2  = 'cmnd/' + self.identificador_componente + '/info2'
    self.topico_info3  = 'cmnd/' + self.identificador_componente + '/info3'
    self.topico_result = 'stat/' + self.identificador_componente + '/RESULT'
    self.topico_state  = 'tele/' + self.identificador_componente + '/STATE'
    self.topico_power = 'stat/' + self.identificador_componente + '/POWER'
    self.topico_online = 'tele/' + self.identificador_componente + '/LWT'
  end
end
