class TokenNotificacaoMobile < ApplicationRecord
  belongs_to :usuario

  validates :token, presence: true
  validates :usuario, presence: true

  def to_s
    "Token #{id}"
  end
end
