class AutomacaoGrupoCondicao < ApplicationRecord
  enum repeat: %i[once every_day weekdays weekends sunday monday tuesday wednesday thursday friday saturday]
  belongs_to :automacao_grupo

  attr_accessor :repeat_view

  def repeat_view
    repeat = repeat_view
  end

  def to_s
    id
  end
end
