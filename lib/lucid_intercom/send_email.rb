# frozen_string_literal: true

require 'lucid_intercom'

module LucidIntercom
  class SendEmail
    #
    # @param post_request [#call]
    #
    def initialize(post_request: Container[:post_request])
      @post_request = post_request
    end

    #
    # @param to [String] a user email address
    # @param subject [String]
    # @param body [String]
    #
    def call(to, subject, body)
      @post_request.('messages', {
        message_type: 'email',
        subject: subject,
        body: body,
        template: 'plain',
        from: {
          type: 'admin',
          id: LucidIntercom.admin_id,
        },
        to: {
          type: 'user',
          email: to,
        },
      })
    end
  end
end
