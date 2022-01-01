4.times do |i|
  app = SystemApplication.create!(
    name: "System Application #{i + 1}",
    # token: Faker::IDNumber.valid,
  )

  chat_num = rand(3..7)

  chat_num.times do |j|
    chat = Chat.create!(
      # number: j + 1,
      system_application: app,
    )

    message_num = rand(3..10)

    message_num.times do |k|
      Message.create!(
        # number: k + 1,
        body: Faker::Lorem.sentence,
        chat: chat,
      )
    end
  end
end
