class GroupAutomation < ApplicationRecord
  belongs_to :group
  has_many :group_automation_conditions
  has_many :group_automation_actions
  enum condition_operator:  %i[and ou]

  def to_s
    name
  end
end
