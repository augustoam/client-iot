class ControlCommand < ApplicationRecord
  belongs_to :control

  def to_s
    self.command.to_s
  end
end
