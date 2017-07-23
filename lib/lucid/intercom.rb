require_relative './intercom/credentials'

module Lucid
  module Intercom
    class << self
      #
      # Assign default API credentials.
      #
      # @param credentials [Lucid::Intercom::Credentials]
      #
      def credentials=(credentials)
        @credentials = credentials
      end

      #
      # @return [Lucid::Intercom::Credentials]
      #
      # @raise [Lucid::Intercom::MissingCredentialsError] if credentials are unset
      #
      def credentials
        raise MissingCredentialsError unless @credentials

        @credentials
      end
    end
  end
end
