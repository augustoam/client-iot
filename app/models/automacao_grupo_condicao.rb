class AutomacaoGrupoCondicao < ApplicationRecord
  enum repeat: %i[once every_day weekdays weekends sunday monday tuesday wednesday thursday friday saturday]
  belongs_to :automacao_grupo
end
