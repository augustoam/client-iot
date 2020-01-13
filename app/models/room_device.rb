class RoomDevice < ApplicationRecord
  belongs_to :group_room
  belongs_to :control

  has_many :user_automation_conditios

  before_create :update_topicos

  validates :name, presence: true
  # after_save { DeviceRoomBroadcastJob.perform_later self }
  def to_s
    [name,id,control.device.name]
  end

  def update_topicos
    if self.identificador_device.present?
      self.topic_info1  = 'cmnd/' + self.identificador_device + '/info1'
      self.topic_info2  = 'cmnd/' + self.identificador_device + '/info2'
      self.topic_info3  = 'cmnd/' + self.identificador_device + '/info3'
      self.topic_result = 'stat/' + self.identificador_device + '/RESULT'
      self.topic_state  = 'tele/' + self.identificador_device + '/STATE'
      self.topic_power = 'stat/' + self.identificador_device + '/POWER'
      self.topic_online = 'tele/' + self.identificador_device + '/LWT'
    end
  end
end
