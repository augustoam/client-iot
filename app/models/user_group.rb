class UserGroup < ApplicationRecord
  belongs_to :group
  belongs_to :user

  before_create :set_admin

  def set_admin
    self.admin = true
  end
end
