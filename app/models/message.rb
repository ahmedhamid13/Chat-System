# frozen_string_literal: true

class Message < ApplicationRecord
  visitable :ahoy_visit
  extend FriendlyId
  friendly_id :number, use: :slugged

  belongs_to :chat

  validates :number, uniqueness: { scope: [:chat] }

  def as_json(options = {})
    options[:except] ||= :id
    super.merge({
      chat: self.chat,
    })
  end
end
