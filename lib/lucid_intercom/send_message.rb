# frozen_string_literal: true

require 'lucid_intercom'

module LucidIntercom
  class SendMessage
    #
    # @param post_request [#call]
    #
    def initialize(post_request: Container[:post_request])
      @post_request = post_request
    end

    #
    # @param to [String] a user email address
    # @param body [String]
    #
    def call(to, body)
      @post_request.('messages', {
        message_type: 'inapp',
        body: body,
        from: {
          type: 'admin',
          id: LucidIntercom.config.admin_id,
        },
        to: {
          type: 'user',
          email: to,
        },
      })
    end
  end
end
