module BotFramework
  class BotState < ApiBase
    def initialize(_service_url)
      @service_url = 'https://state.botframework.com'
    end

    # DeleteStateForUser
    # Delete all data for a user in a channel (UserData and PrivateConversationData)
    # @param channel_id channelId
    # @param user_id id for the user on the channel
    # @param [Hash] opts the optional parameters
    # @return [Array<String>]
    def delete_state_for_user(opts = {})
      uri = "/v3/botstate/#{opts['channel_id']}/users/#{opts['user_id']}"
      api_delete(uri)
    end

    # GetConversationData
    # get the bots data for all users in a conversation
    # @param channel_id the channelId
    # @param conversation_id The id for the conversation on the channel
    # @param [Hash] opts the optional parameters
    # @return [BotData]

    def get_conversation_data(opts = {})
      # opts['channel_id'] & opts['conversation_id']
      uri = "/v3/botstate/#{opts['channel_id']}/conversations/#{opts['conversation_id']}"
      api_get(uri)
    end

    # GetPrivateConversationData
    # get bot's data for a single user in a conversation
    # @param channel_id channelId
    # @param conversation_id The id for the conversation on the channel
    # @param user_id id for the user on the channel
    def get_private_conversation_date(opts = {})
      uri = "/v3/botstate/#{opts['channel_id']}/conversations/#{opts['conversation_id']}/users/#{opts['user_id']}"
      api_get(uri)
    end

    # GetUserData
    # Get a bots data for the user across all conversations
    # @param channel_id channelId
    # @param user_id id for the user on the channel
    # @return [BotData]

    def get_user_data(opts = {})
      uri = "/v3/botstate/#{opts['channel_id']}/users/#{opts['user_id']}"
      api_get(uri)
    end

    # SetConversationData
    # Update the bot's data for all users in a conversation
    # @param channel_id channelId
    # @param conversation_id The id for the conversation on the channel
    # @param bot_data the new botdata
    # @return [BotData]
    def set_conversation_data(opts = {})
      uri = "/v3/botstate/#{opts['channel_id']}/conversations/#{opts['conversation_id']}"
      api_post(uri, opts['bot_data'])
    end

    # SetPrivateConversationData
    # Update the bot's data for a single user in a conversation
    # @param channel_id channelId
    # @param conversation_id The id for the conversation on the channel
    # @param user_id id for the user on the channel
    # @param bot_data the new botdata
    # @param [Hash] opts the optional parameters
    # @return [BotData]

    def set_private_conversation_data(opts = {})
      uri = "/v3/botstate/#{opts['channel_id']}/conversations/#{opts['conversation_id']}/users/#{opts['user_id']}"
      api_post(uri, opts['bot_data'])
    end
    # SetUserData
    # Update the bot's data for a user
    # @param channel_id channelId
    # @param user_id id for the user on the channel
    # @param bot_data the new botdata
    # @param [Hash] opts the optional parameters
    # @return [BotData]

    def set_user_data(opts = {})
      uri = "/v3/botstate/#{opts['channel_id']}/users/#{opts['user_id']}"
      api_post(uri, opts['bot_data'])
    end
  end
end
