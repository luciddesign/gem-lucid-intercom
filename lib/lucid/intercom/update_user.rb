require 'json'
require 'net/http'
require 'uri'

require_relative '../intercom'
require_relative './attributes'
require_relative './errors'

module Lucid
  module Intercom
    class UpdateUser
      attr_reader :attributes

      #
      # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
      # @param app_attributes [Hash] app-specific attributes (unprefixed)
      #
      def initialize(shop_attributes, app_attributes)
        @attributes = Attributes.new(shop_attributes, app_attributes)
      end

      #
      # Create or update user identified by attributes.
      #
      # @raise [Lucid::Intercom::RequestError] if the response status >= 400
      #
      def call
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req, data)
        end

        if res.code.to_i >= 400
          raise Lucid::Intercom::RequestError.new(res.code), 'invalid response code %s' % res.code.to_i
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
        req['Authorization'] = "Bearer #{Lucid::Intercom::APP_ACCESS_TOKEN}"
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
