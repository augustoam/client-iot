class NotificationToken < ApplicationRecord
  belongs_to :user

  validates :token, presence: true
  validates :user, presence: true

  def to_s
    "Token #{id}"
  end
end
