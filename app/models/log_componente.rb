class LogComponente < ApplicationRecord
  belongs_to :grupo
  belongs_to :usuario
  belongs_to :componente
end
