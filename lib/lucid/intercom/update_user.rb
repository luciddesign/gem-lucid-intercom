require 'json'
require 'net/http'
require 'uri'

require_relative '../intercom'
require_relative './attributes'
require_relative './errors'

module Lucid
  module Intercom
    class UpdateUser
      #
      # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
      # @param app_attributes [Hash] app-specific attributes (unprefixed)
      # @param credentials [Lucid::Intercom::Credentials]
      #
      def initialize(shop_attributes, app_attributes, credentials: nil)
        @credentials = credentials || Lucid::Intercom.credentials

        @attributes = Attributes.new(shop_attributes, app_attributes, credentials: @credentials)
      end

      attr_reader :attributes
      attr_reader :credentials

      #
      # Create or update user identified by attributes.
      #
      # @raise [Lucid::Intercom::RequestError] if the response status >= 400
      #
      def call
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req, data)
        end

        status = res.code.to_i

        if status >= 400
          raise Lucid::Intercom::RequestError.new(status), 'invalid response code %s' % status
        end
      end

      #
      # @return [URI::HTTPS]
      #
      private def uri
        URI('https://api.intercom.io/users')
      end

      #
      # @return [Net::HTTP::Post]
      #
      private def req
        req = Net::HTTP::Post.new(uri)
        req['Authorization'] = "Bearer #{credentials.access_token}"
        req['Accept'] = 'application/json'
        req['Content-Type'] = 'application/json'

        req
      end

      #
      # @return [Hash]
      #
      private def data
        user = attributes.user
        user[:companies] = [attributes.company]
        user[:companies][0]['custom_attributes'] = attributes.custom

        user.to_json
      end
    end
  end
end
