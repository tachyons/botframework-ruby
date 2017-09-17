BotFramework.configure do |connector|
  connector.app_id = ENV['MICROSOFT_APP_ID']
  connector.app_secret = ENV['MICROSOFT_APP_SECRET']
end

BotFramework::Bot.on :activity do |activity|
  # All activities
end

BotFramework::Bot.on :message do |activity|
  # Thumbnail card
  activity.reply_activity(
    BotFramework::Activity.new(
      type: 'message',
      from: activity.recipient.to_hash,
      attachments: [
        BotFramework::Attachment.new(
          content_type: 'application/vnd.microsoft.card.thumbnail',
          name: 'thumbnail card sample',
          content: BotFramework::ThumbnailCard.new(
            title: 'Title',
            subtitle: 'subtitle',
            images: [
              BotFramework::CardImage.new(
                url: 'https://sec.ch9.ms/ch9/7ff5/e07cfef0-aa3b-40bb-9baa-7c9ef8ff7ff5/buildreactionbotframework_960.jpg',
                alt: 'Alt text'
              )
            ]
          )
        )
      ]
    )
  )

  # Hero card
  activity.reply_activity(
    BotFramework::Activity.new(
      type: 'message',
      from: activity.recipient.to_hash,
      attachments: [
        BotFramework::Attachment.new(
          content_type: 'application/vnd.microsoft.card.hero',
          name: 'Hero card sample',
          content: BotFramework::HeroCard.new(
            title: 'Hero Title',
            subtitle: 'Hero subtitle',
            text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            images: [
              BotFramework::CardImage.new(
                url: 'https://sec.ch9.ms/ch9/7ff5/e07cfef0-aa3b-40bb-9baa-7c9ef8ff7ff5/buildreactionbotframework_960.jpg',
                alt: 'Alt text'
              )
            ]
          )
        )
      ]
    )
  )

  # Receipt card

  if activity.channel_id != 'facebook'
    activity.reply_activity(
      BotFramework::Activity.new(
        type: 'message',
        from: activity.recipient.to_hash,
        attachments: [
          BotFramework::Attachment.new(
            content_type: 'application/vnd.microsoft.card.receipt',
            name: 'thumbnail card sample',
            content: BotFramework::ReceiptCard.new(
              title: 'Title',
              total: '100',
              vat: '10',
              facts: [],
              items: [
                BotFramework::ReceiptItem.new(
                  title: 'Item1',
                  price: '10',
                  quantity: '1kg'
                )
              ]
            )
          )
        ]
      )
    )
  end

  # Signin card
  activity.reply_activity(
    BotFramework::Activity.new(
      type: 'message',
      from: activity.recipient.to_hash,
      attachments: [
        BotFramework::Attachment.new(
          content_type: 'application/vnd.microsoft.card.signin',
          name: 'Signin card sample',
          content: BotFramework::ThumbnailCard.new(
            text: 'Signin',
            buttons: [
              BotFramework::CardAction.new(
                title: 'signin',
                type: 'signin',
                value: 'https://github.com'
              )
            ]
          )
        )
      ]
    )
  )

  # Animation card
  activity.reply_activity(
    BotFramework::Activity.new(
      type: 'message',
      from: activity.recipient.to_hash,
      attachments: [
        BotFramework::Attachment.new(
          content_type: 'application/vnd.microsoft.card.animation',
          name: 'Animation sample sample',
          content: BotFramework::AnimationCard.new(
            title: 'Animation card',
            subtitle: 'subtitle',
            media: [
              BotFramework::MediaUrl.new(
                url: 'http://i.giphy.com/Ki55RUbOV5njy.gif'
              )
            ]
          )
        )
      ]
    )
  )

  # Video card
  activity.reply_activity(
    BotFramework::Activity.new(
      type: 'message',
      from: activity.recipient.to_hash,
      attachments: [
        BotFramework::Attachment.new(
          content_type: 'application/vnd.microsoft.card.video',
          name: 'thumbnail card sample',
          content: BotFramework::VideoCard.new(
            title: 'Title',
            subtitle: 'subtitle',
            text: 'Big Buck Bunny (code-named Peach) is a short computer-animated comedy film by the Blender',
            media: [
              BotFramework::MediaUrl.new(
                url: 'http://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_320x180.mp4'
              )
            ],
            image: BotFramework::ThumbnailUrl.new(
              url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Big_buck_bunny_poster_big.jpg/220px-Big_buck_bunny_poster_big.jpg'
            ),
            buttons: [
              BotFramework::CardAction.new(
                type: 'openUrl',
                value: 'https://peach.blender.org/',
                title: 'Learn more'
              )
            ]
          )
        )
      ]
    )
  )

  # Audio card
  activity.reply_activity(
    BotFramework::Activity.new(
      type: 'message',
      from: activity.recipient.to_hash,
      attachments: [
        BotFramework::Attachment.new(
          content_type: 'application/vnd.microsoft.card.audio',
          name: 'Audio card sample',
          content: BotFramework::AudioCard.new(
            title: 'I am your father',
            subtitle: 'subtitle',
            media: [
              BotFramework::MediaUrl.new(
                url: 'http://www.wavlist.com/movies/004/father.wav'
              )
            ]

          )
        )
      ]
    )
  )
end

BotFramework::Bot.on :ping do |activity|
  # Callback for pings
end

BotFramework::Bot.on :typing do |activity|
  # Callback for typing
end
