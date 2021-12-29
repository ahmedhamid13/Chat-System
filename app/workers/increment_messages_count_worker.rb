# frozen_string_literal: true

class IncrementMessagesCountWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'normal_priority', retry: 3

  def perform(chat_id)
    chat = Chat.find(chat_id)

    chat.messages_count = chat.messages_count.to_i +  1
    chat.save
  end
end
