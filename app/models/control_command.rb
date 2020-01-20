class ControlCommand < ApplicationRecord
  belongs_to :control

  def to_s
    command.to_s
  end
end
