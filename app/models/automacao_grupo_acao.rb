class AutomacaoGrupoAcao < ApplicationRecord
  # enum repeat: %i[once every_day weekdays weekends sunday monday tuesday wednesday thursday friday saturday]
  belongs_to :automacao_grupo
  belongs_to :componente_ambiente, required: false
  belongs_to :componente_ambiente, required: false, foreign_key: :run_automacao_id
  belongs_to :componente_ambiente, required: false, foreign_key: :turn_on_off_automation_id

  def to_s
    id
  end

end
