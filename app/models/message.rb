class Message < ApplicationRecord
  visitable :ahoy_visit
  extend FriendlyId
  friendly_id :number, use: :slugged

  belongs_to :chat

  validates :number, uniqueness: { scope: [:chat] }
end
