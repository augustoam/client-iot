class GroupAutomation < ApplicationRecord
  belongs_to :user_group
  has_many :group_automation_conditions
  has_many :group_automation_actions
  enum condition_operator: [:and, :ou]

  def to_s
    self.name
  end
end
