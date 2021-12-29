# frozen_string_literal: true

class Message < ApplicationRecord
  include SearchableMessage

  extend FriendlyId
  friendly_id :number, use: :slugged

  belongs_to :chat
  has_one :system_application, through: :chat, source: :system_application

  validates :number, :chat, presence: true
  validates :number, uniqueness: { scope: [:chat] }
  validates :body, length: { maximum: 3000 }

  before_validation :set_number, on: :create

  def set_number
    self.number = chat.messages.any? ? (chat.messages.last.number + 1) : 1
  end

  after_create :set_chat_count_up

  def set_chat_count_up
    # self.chat.update(messages_count: (self.chat.messages_count.to_i + 1)) if chat.present?
    IncrementMessagesCountWorker.perform_async(self.chat_id)
  end

  after_destroy :set_chat_count_down

  def set_chat_count_down
    # self.chat.update(messages_count: (self.chat.messages_count.to_i - 1) < 0 ? 0 : (self.chat.messages_count - 1)) if chat.present?
    DecrementMessagesCountWorker.perform_async(self.chat_id)
  end

  def as_json(options = {})
    options[:except] ||= :id
    super.merge({
      chat_number: self.chat.number,
      # chat: self.chat,
    })
  end
end
