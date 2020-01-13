class UserAutomationAction < ApplicationRecord
  # enum repeat: %i[once every_day weekdays weekends sunday monday tuesday wednesday thursday friday saturday]
  enum type: %i[run_automation turn_on_off_automation send_notification delay device]
  enum turn_on_off: %i[on off]

  belongs_to :user_automation, foreign_key: :user_automation_id
  belongs_to :room_device, required: false, foreign_key: :room_device_id
  belongs_to :run_automation, class_name: 'UserAutomation', required: false, foreign_key: :run_automation_id
  belongs_to :turn_on_off_automation, class_name: 'UserAutomation', required: false, foreign_key: :turn_on_off_automation_id
  belongs_to :control_command

  attr_accessor :propriedades

  def to_s
    id
  end

end
