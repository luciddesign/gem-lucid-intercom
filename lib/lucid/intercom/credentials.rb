module Lucid
  module Intercom
    class Credentials
      #
      # @param access_token [String]
      # @param secret [String]
      # @param app_id [String]
      # @param app_prefix [String] the snakecased app name, e.g. 'smart_order_tags'
      #
      def initialize(access_token:, secret:, app_id:, app_prefix:)
        @access_token = access_token
        @secret = secret
        @app_id = app_id
        @app_prefix = app_prefix
      end

      attr_reader :access_token
      attr_reader :secret
      attr_reader :app_id
      attr_reader :app_prefix
    end
  end
end
