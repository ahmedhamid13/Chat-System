# frozen_string_literal: true

require "sidekiq-scheduler"

class UpdateChatsCount
  include Sidekiq::Worker
  sidekiq_options queue: "high_priority", retry: 3

  def perform
    SystemApplication.includes(:chats).all.each do |system_application|
      system_application.update!(chats_count: system_application.chats.size)
    end
  end
end
