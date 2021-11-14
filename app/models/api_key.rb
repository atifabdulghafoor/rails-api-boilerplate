class ApiKey < ApplicationRecord
  validates :token, presence: true
end
