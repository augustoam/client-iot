class AutomacaoGrupoCondicao < ApplicationRecord
  # enum repeat: %i[once every_day weekdays weekends sunday monday tuesday wednesday thursday friday saturday]
  enum tipo_condicao: [:complete_manually, :timer, :componente]
  belongs_to :automacao_grupo, foreign_key: :automacao_grupo_id
  belongs_to :componente_ambiente, required: false, foreign_key: :componente_ambiente_id
  belongs_to :controle_comando, class_name: 'ControleComando', required: false, foreign_key: :controle_comando_id

  before_save :update_columns
  
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
      controle_comando_id = nil
    end
    if tipo_condicao == 'timer'
      componente_ambiente_id = nil
      controle_comando_id = nil
    end
    if tipo_condicao == 'componente'
      repeat = nil
      turn_on = nil
    end
  end

  def set_schedule
    if tipo_condicao == 'timer'
      if repeat.include?('once')
        Sidekiq.set_schedule("#{id}_publish_mqtt", { 'at' => turn_on, 'class' => 'MqttPublishJob', 'args' => "#{self.automacao_grupo.id}" })
      else
        turn_time = human_datetime(turn_on)
        every = 'every '
        case
        when repeat.include?('every_day')
          time_cron = human_time(turn_on).concat(' * * 0-7')
        when repeat.include?('weekends')
          time_cron = human_time(turn_on).concat(' * * 0-6')
        when repeat.include?('weekdays')
          time_cron = human_time(turn_on).concat(' * * 1,2,3,4,5')
        else
          JSON.parse(repeat).each_with_index do |option, index|

            every.concat(option)
            if index != JSON.parse(repeat).count-1 && option != ""
              every.concat(' and ')
            end
          end
          every.concat(' ', turn_time)
          time_cron = Fugit::Nat.parse(every).to_cron_s
        end

        self.schedule_cron = time_cron
        Sidekiq.set_schedule("#{id}_publish_mqtt", { 'cron' => time_cron, 'class' => 'MqttPublishJob', 'args' => "#{self.automacao_grupo.id}" })
      end
    end
  end

  def human_datetime(time, pattern = '%d %Y %H:%M')
    sanitize_datetime(time).strftime(pattern) if time
  end

  def human_time(time, pattern = '%M %H')
    sanitize_datetime(time).strftime(pattern) if time
  end

  private

  def sanitize_datetime(value)
    value.is_a?(String) ? DateTime.parse(value) : value
  end
end
