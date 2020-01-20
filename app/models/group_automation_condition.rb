class GroupAutomationCondition < ApplicationRecord
  # enum repeat: %i[once every_day weekdays weekends sunday monday tuesday wednesday thursday friday saturday]
  enum type_condition:  %i[complete_manually timer device]
  belongs_to :group_automation, foreign_key: :group_automation_id
  belongs_to :room_device, required: false, foreign_key: :room_device_id
  belongs_to :control_command, class_name: 'ControlCommand', required: false, foreign_key: :control_command_id

  before_save :update_columns

  before_save :set_schedule

  scope :do_group, -> (group_automation) {
      where(group_automation_id: group_automation)
    }

  def to_s
    id
  end

  def update_columns
    if type_condition == 'complete_manually'
      self.repeat = nil
      self.turn_on = nil
      self.room_device_id = nil
      self.control_command_id = nil
      self.value_set = nil
    end
    if type_condition == 'timer'
      self.room_device_id = nil
      self.control_command_id = nilc
      self.value_set = nil
    end
    if type_condition == 'device'
      self.repeat = nil
      self.turn_on = nil
    end
  end

  def set_schedule
    # if type_condition == 'timer'
    #   if repeat.include?('once')
    #     Sidekiq.set_schedule("#{id}_publish_mqtt", { 'at' => turn_on, 'class' => 'MqttPublishJob', 'args' => "#{self.group_automation.id}" })
    #   else
    #     turn_time = human_datetime(turn_on)
    #     every = 'every '
    #     case
    #     when repeat.include?('every_day')
    #       time_cron = human_time(turn_on).concat(' * * 0-7')
    #     when repeat.include?('weekends')
    #       time_cron = human_time(turn_on).concat(' * * 0-6')
    #     when repeat.include?('weekdays')
    #       time_cron = human_time(turn_on).concat(' * * 1,2,3,4,5')
    #     else
    #       JSON.parse(repeat).each_with_index do |option, index|

    #         every.concat(option)
    #         if index != JSON.parse(repeat).count-1 && option != ""
    #           every.concat(' and ')
    #         end
    #       end
    #       every.concat(' ', turn_time)
    #       time_cron = Fugit::Nat.parse(every).to_cron_s
    #     end

    #     self.schedule_cron = time_cron
    #     Sidekiq.set_schedule("#{id}_publish_mqtt", { 'cron' => time_cron, 'class' => 'MqttPublishJob', 'args' => "#{self.group_automation.id}" })
    #   end
    # end
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