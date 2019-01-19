class AutomacaoGrupoAcao < ApplicationRecord
  # enum repeat: %i[once every_day weekdays weekends sunday monday tuesday wednesday thursday friday saturday]
  enum tipo_acao: %i[run_automation turn_on_off_automation send_notification delay componente]

  belongs_to :automacao_grupo, foreign_key: :automacao_grupo_id
  belongs_to :componente_ambiente, required: false, foreign_key: :componente_ambiente_id
  belongs_to :automacao_grupo, required: false, foreign_key: :run_automacao_id
  belongs_to :automacao_grupo, required: false, foreign_key: :turn_on_off_automation_id
  belongs_to :componente_propriedade, required: false, foreign_key: :componente_propriedade_id

  def to_s
    id
  end

end
