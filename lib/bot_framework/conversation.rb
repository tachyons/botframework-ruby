module BotFramework
  class Conversation < ApiBase
    def create(attributes)
      uri = '/v3/conversations'
      api_post(uri, attributes)
    end

    def get_activity_members(conversation_id, activity_id, opts = {})
      uri = "/v3/conversations/#{conversation_id}/activities/#{activity_id}/members"
      api_get(uri, opts)
    end

    def get_conversation_members(conversation_id)
      uri = "/v3/conversations/#{conversation_id}/activities/members"
      api_get(uri, opts)
    end

    def send(conversation_id, activity)
      uri = "/v3/conversations/#{conversation_id}/activities"
      api_post(uri, activity.as_json)
    end

    def upload_attachment(conversation_id, opts = {})
      uri = "/v3/conversations/#{conversation_id}/attachments"
      api_post(uri, opts)
    end

    def reply_to_activity(conversation_id, activity_id, new_activity)
      uri = "/v3/conversations/#{conversation_id}/activities/#{activity_id}"
      api_post(uri, new_activity.to_hash)
    end
  end
end
