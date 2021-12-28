# frozen_string_literal: true

module Api::V1::Chat
  def chat_json(chat, includes = [], _options = {})
    return {} unless chat

    res = chat.as_json(include_root: false,
                       except: %w[id],
                       only: %w[slug number messages_count application_token created_at updated_at])

    includes = includes.map(&:to_sym)
    res[:system_application] = chat.system_application if includes.include?(:system_application)
    res[:messages] = chat.messages if includes.include?(:messages)

    res
  end

  def chats_json(chats, includes = [], options = {})
    chats.map { |s| chat_json(s, includes, options) }
  end
end
