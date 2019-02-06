class AutomacaoGrupoCondicao < ApplicationRecord
  # enum repeat: %i[once every_day weekdays weekends sunday monday tuesday wednesday thursday friday saturday]
  enum tipo_condicao: [:complete_manually, :timer, :componente]
  belongs_to :automacao_grupo, foreign_key: :automacao_grupo_id
  belongs_to :componente_ambiente, required: false, foreign_key: :componente_ambiente_id
  belongs_to :componente_propriedade, required: false, foreign_key: :componente_propriedade_id

  before_save :update_columns

  attr_accessor :propriedade

  before_save :set_schedule

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

  def set_schedule
    debugger
    turn_time = human_datetime(turn_on)

    cron = 'every '

    case
    when repeat.include?('every_day')
      cron.concat('day')
    when repeat.include?('weekdays')
      cron.concat('weekday')
    when repeat.include?('weekends')
      cron.concat('sunday and saturday')
    end
    debugger

    JSON.parse(repeat).each_with_index do |option, index|
      cron.concat(option)
      if index != JSON.parse(repeat).count-1 && option != ""
        cron.concat(' and ')
      end
    end
    debugger

    cron.concat(' ', turn_time)

    time = Fugit::Nat.parse(cron).to_cron_s
    Sidekiq.set_schedule("#{id}_publish_mqtt", { 'cron' => time, 'class' => 'MqttPublishJob', 'args' => "#{self.automacao_grupo.id}" })
  end

  #   human_datetime(DateTime.now) # agora é 07/04/2017 10:30
  #   # => 07/04/2017 10:30
  def human_datetime(time, pattern = '%a, %d %b %Y %H:%M')
    sanitize_datetime(time).strftime(pattern) if time
  end

  private

  def sanitize_datetime(value)
    value.is_a?(String) ? DateTime.parse(value) : value
  end
end
