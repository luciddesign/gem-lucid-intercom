# frozen_string_literal: true

require 'lucid_intercom/container'

module LucidIntercom
  class SendEvent
    #
    # @param post_request [#call]
    # @param send_event [#call]
    #
    def initialize(post_request: Container[:post_request],
                   update_user: Container[:update_user])
      @post_request = post_request
      @update_user = update_user
    end

    #
    # @param event [Events::Event]
    #
    # @raise [Response::ClientError] for status 4xx
    # @raise [Response::ServerError] for status 5xx
    #
    def call(event)
      @post_request.('events', data(event)).assert!

      @update_user.(event)
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
