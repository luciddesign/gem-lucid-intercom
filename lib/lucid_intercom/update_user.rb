# frozen_string_literal: true

require 'lucid_intercom/container'

module LucidIntercom
  class UpdateUser
    extend Dry::Initializer

    # @return [PostRequest]
    option :post_request, default: proc { Container[:post_request] }

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
      data = data(event)

      post_request.('users', data).assert!
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
