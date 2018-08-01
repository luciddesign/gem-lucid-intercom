# frozen_string_literal: true

require 'lucid_intercom/container'

module LucidIntercom
  class SendEvent
    extend Dry::Initializer

    # @return [PostRequest]
    option :post_request, default: proc { Container[:post_request] }
    # @return [UpdateUser]
    option :update_user, default: proc { Container[:update_user] }

    #
    # @param event [Events::Event]
    #
    # @raise [Response::ClientError] for status 4xx
    # @raise [Response::ServerError] for status 5xx
    #
    def call(event)
      post_request.('events', data(event)).assert!

      update_user.(event)
    end

    #
    # @param event [Events::Event]
    #
    # @return [Hash]
    #
    private def data(event)
      {
        **event.user_id,
        event_name: event.event_name,
        created_at: Time.now.utc.to_i,
        metadata: event.event_metadata,
      }
    end
  end
end
