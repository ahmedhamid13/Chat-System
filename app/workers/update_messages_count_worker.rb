# frozen_string_literal: true

require "sidekiq-scheduler"

class UpdateMessagesCount
  include Sidekiq::Worker
  sidekiq_options queue: "high_priority", retry: 3

  def perform
    Chat.includes(:messages).all.each do |chat|
      chat.update!(messages_count: chat.messages.size)
    end
  end
end
