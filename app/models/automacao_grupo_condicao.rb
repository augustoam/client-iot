class AutomacaoGrupoCondicao < ApplicationRecord
  # enum repeat: %i[once every_day weekdays weekends sunday monday tuesday wednesday thursday friday saturday]
  enum tipo_condicao: [:complete_manually, :timer, :componente]
  belongs_to :automacao_grupo, foreign_key: :automacao_grupo_id
  belongs_to :componente_ambiente, required: false, foreign_key: :componente_ambiente_id
  belongs_to :componente_propriedade, required: false, foreign_key: :componente_propriedade_id

  before_save :update_columns

  attr_accessor :propriedade

  scope :do_grupo, -> (automacao_grupo) {
      where(automacao_grupo_id: automacao_grupo)
    }

  def to_s
    id
  end

  def update_columns
    if tipo_condicao == 'complete_manually'
      repeat = nil
      turn_on = nil
      componente_ambiente_id = nil
      componente_propriedade_id = nil
    end
    if tipo_condicao == 'timer'
      componente_ambiente_id = nil
      componente_propriedade_id = nil
    end
    if tipo_condicao == 'componente'
      repeat = nil
      turn_on = nil
    end
  end
end
