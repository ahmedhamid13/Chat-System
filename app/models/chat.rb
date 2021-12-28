# frozen_string_literal: true

class Chat < ApplicationRecord
  visitable :ahoy_visit
  extend FriendlyId
  friendly_id :number, use: :slugged

  belongs_to :system_application
  has_many :messages, dependent: :destroy

  validates :number, :system_application, presence: true
  validates :number, uniqueness: { scope: [:system_application] }
  validates :messages_count, numericality: { greater_than_or_equal_to: 0 }, if: -> { messages_count.present? }

  before_validation :set_number, on: :create

  def set_number
    current_numbers = self.system_application.chats.pluck(:number)
    current_numbers_length = current_numbers.size
    total = (current_numbers_length + 1) * (current_numbers_length + 2) / 2
    uniq_num = (total - current_numbers.sum).abs

    while self.system_application.chats.find_by_number(uniq_num).present?
      uniq_num = system_application.get_uniq_number
    end

    self.number = uniq_num
  end

  after_create :set_system_application_count_up

  def set_system_application_count_up
    self.system_application.update(chats_count: (self.system_application.chats_count.to_i + 1)) if system_application.present?
  end

  after_destroy :set_system_application_count_down

  def set_system_application_count_down
    self.system_application.update(chats_count: (self.system_application.chats_count.to_i - 1) < 0 ? 0 : (self.system_application.chats_count - 1)) if system_application.present?
  end

  def as_json(options = {})
    options[:except] ||= :id
    super
    super.merge({
      application_token: self.system_application.token,
      # application: self.system_application,
    })
  end
end
