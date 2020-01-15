class UserAutomation < ApplicationRecord
  belongs_to :group
  has_many :user_automation_conditions
  has_many :user_automation_actions
  enum condition_operator: [:and, :ou]

  def to_s
    self.name
  end
end
