class GroupAutomationAction < ApplicationRecord
  # enum repeat: %i[once every_day weekdays weekends sunday monday tuesday wednesday thursday friday saturday]
  enum type_action: %i[run_automation turn_on_off_automation send_notification delay device]
  enum turn_on_off: %i[on off]

  belongs_to :group_automation, foreign_key: :group_automation_id
  belongs_to :room_device, required: false, foreign_key: :room_device_id
  belongs_to :run_automation, class_name: 'GroupAutomation', required: false, foreign_key: :run_automation_id
  belongs_to :turn_on_off_automation, class_name: 'GroupAutomation', required: false, foreign_key: :turn_on_off_automation_id
  belongs_to :control_command, required: false

  def to_s
    id
  end
end
