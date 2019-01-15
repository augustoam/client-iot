class AutomacaoGrupoCondicao < ApplicationRecord
  # enum repeat: %i[once every_day weekdays weekends sunday monday tuesday wednesday thursday friday saturday]
  belongs_to :automacao_grupo
  belongs_to :componente_ambiente, required: false

  attr_accessor :propriedade
  # attr_accessor :once, :every_day, :weekdays, :weekends, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday

  def to_s
    id
  end

end
