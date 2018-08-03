# frozen_string_literal: true

require 'lucid_intercom/container'

module LucidIntercom
  class UpdateUser
    #
    # @param post_request [#call]
    #
    def initialize(post_request: Container[:post_request])
      @post_request = post_request
    end

    #
    # Create or update user identified by event attributes. This is only used in
    # the context of events.
    #
    # @param event [Events::Event]
    #
    # @raise [Response::ClientError] for status 4xx
    # @raise [Response::ServerError] for status 5xx
    #
    def call(event)
      @post_request.('users', data(event)).assert!
    end

    #
    # @param event [Events::Event]
    #
    # @return [Hash]
    #
    private def data(event)
      event.user.to_h.merge(
        companies: [
          event.company.to_h.merge(
            custom_attributes: event.company_custom.to_h
          ),
        ]
      )
    end
  end
end
