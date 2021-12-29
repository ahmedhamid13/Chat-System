# frozen_string_literal: true

class IncrementChatsCountWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'normal_priority', retry: 3

  def perform(application_id)
    application = SystemApplication.find(application_id)

    application.chats_count = application.chats_count.to_i + 1
    application.save
  end
end
