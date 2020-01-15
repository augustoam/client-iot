class UserAutomationCondition < ApplicationRecord
  # enum repeat: %i[once every_day weekdays weekends sunday monday tuesday wednesday thursday friday saturday]
  enum type: [:complete_manually, :timer, :device]
  belongs_to :user_automation, foreign_key: :user_automation_id
  belongs_to :room_device, required: false, foreign_key: :room_device_id
  belongs_to :control_command, class_name: 'ControlCommand', required: false, foreign_key: :control_command_id

  before_save :update_columns

  attr_accessor :propriedade

  before_save :set_schedule

  scope :do_group, -> (automacao_group) {
      where(automacao_group_id: automacao_group)
    }

  def to_s
    id
  end

  def update_columns
    if tipo_condicao == 'complete_manually'
      repeat = nil
      turn_on = nil
      device_room_id = nil
      device_propriedade_id = nil
    end
    if tipo_condicao == 'timer'
      device_room_id = nil
      device_propriedade_id = nil
    end
    if tipo_condicao == 'device'
      repeat = nil
      turn_on = nil
    end
  end

  def set_schedule
    if tipo_condicao == 'timer'
      if repeat.include?('once')
        Sidekiq.set_schedule("#{id}_publish_mqtt", { 'at' => turn_on, 'class' => 'MqttPublishJob', 'args' => "#{self.automacao_group.id}" })
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
        Sidekiq.set_schedule("#{id}_publish_mqtt", { 'cron' => time_cron, 'class' => 'MqttPublishJob', 'args' => "#{self.automacao_group.id}" })
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
