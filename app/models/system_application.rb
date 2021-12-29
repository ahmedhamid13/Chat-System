# frozen_string_literal: true

class SystemApplication < ApplicationRecord
  visitable :ahoy_visit
  extend FriendlyId
  friendly_id :token, use: :slugged

  has_many :chats, dependent: :destroy
  has_many :messages, -> { distinct }, through: :chats, source: :messages, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { maximum: 255 }
  validates :token, presence: true, uniqueness: true
  validates :chats_count, numericality: { greater_than_or_equal_to: 0 }, if: -> { chats_count.present? }

  before_validation :set_token, on: :create

  def set_token
    tokens = SystemApplication.all.pluck(:token)
    while true
      token = SecureRandom.hex(14)
      break if tokens.exclude?(token) && SystemApplication.all.find_by_token(token).nil?
    end
    self.token = token
  end

  def get_uniq_number
    i = 1
    current_numbers = self.chats.pluck(:number)

    while current_numbers.include?(i)
      i += 1
    end

    i
  end
end
