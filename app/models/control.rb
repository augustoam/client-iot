class Control < ApplicationRecord
  has_many :control_commands
  belongs_to :layout_control
  belongs_to :device
  belongs_to :manufacturer
  validates :name, presence: true

  def to_s
    name.to_s
  end
end
