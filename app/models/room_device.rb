class RoomDevice < ApplicationRecord
  belongs_to :group_room
  belongs_to :control

  has_many :group_automation_conditions

  before_create :update_topics

  validates :name, presence: true
  # after_save { RoomDeviceBroadcastJob.perform_later self }
  def to_s
    [name,id,control.device.name]
  end

  def update_topics
    if self.topic_id.present?
      self.topic_info1  = 'cmnd/' + self.topic_id + '/info1'
      self.topic_info2  = 'cmnd/' + self.topic_id + '/info2'
      self.topic_info3  = 'cmnd/' + self.topic_id + '/info3'
      self.topic_result = 'stat/' + self.topic_id + '/RESULT'
      self.topic_state  = 'tele/' + self.topic_id + '/STATE'
      self.topic_power = 'stat/' + self.topic_id + '/POWER'
      self.topic_online = 'tele/' + self.topic_id + '/LWT'
    end
  end
end
