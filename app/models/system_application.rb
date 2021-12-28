class SystemApplication < ApplicationRecord
  visitable :ahoy_visit
  extend FriendlyId
  friendly_id :token, use: :slugged

  has_many :chats, dependent: :destroy
  has_many :messages, -> { distinct }, through: :chats, source: :messages, dependent: :destroy
end
