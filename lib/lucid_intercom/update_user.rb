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
    # Create or update user.
    #
    # @param user [UserAttributes]
    #
    # @raise [Response::ClientError] for status 4xx
    # @raise [Response::ServerError] for status 5xx
    #
    def call(user)
      @post_request.('users', data(user)).assert!
    end

    #
    # @param user [UserAttributes]
    #
    # @return [Hash]
    #
    private def data(user)
      user.to_h.merge(
        companies: [
          user.company.to_h.merge(
            custom_attributes: user.company.custom.to_h
          ),
        ]
      )
    end
  end
end
