class AutomacaoGrupoCondicao < ApplicationRecord
  # enum repeat: %i[once every_day weekdays weekends sunday monday tuesday wednesday thursday friday saturday]
  enum tipo_condicao: [:complete_manually, :timer, :componente]
  belongs_to :automacao_grupo, foreign_key: :automacao_grupo_id
  belongs_to :componente_ambiente, required: false, foreign_key: :componente_ambiente_id
  belongs_to :componente_propriedade, required: false, foreign_key: :componente_propriedade_id

  attr_accessor :propriedade
  # attr_accessor :once, :every_day, :weekdays, :weekends, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday

  def to_s
    id
  end
end
