require 'json'
require 'net/http'
require 'uri'

require_relative '../intercom'
require_relative './attributes'

module Lucid
  module Intercom
    class SendEvent
      RequestError = Class.new(StandardError)

      attr_reader :attributes

      #
      # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
      #
      def initialize(shop_attributes)
        @attributes = Attributes.new(shop_attributes, {})
      end

      #
      # Create or update user identified by attributes.
      #
      # @param event_name [String]
      # @param event_metadata [Hash]
      #
      # @raise [RequestError] if the response status >= 400
      #
      def call(event_name, event_metadata)
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req, data(event_name, event_metadata))
        end

        if res.code.to_i >= 400
          raise RequestError, 'invalid response code %s' % res.code.to_i
        end
      end

      #
      # @return [URI::HTTPS]
      #
      private def uri
        URI('https://api.intercom.io/events')
      end

      #
      # @return [Net::HTTP::Post]
      #
      private def req
        req = Net::HTTP::Post.new(uri)
        req['Authorization'] = "Bearer #{Lucid::Intercom::APP_ACCESS_TOKEN}"
        req['Content-Type'] = 'application/json'

        req
      end

      #
      # @param event_name [String]
      # @param event_metadata [Hash]
      #
      # @return [Hash]
      #
      private def data(event_name, event_metadata)
        event = {}
        event[:email] = attributes.user[:email]
        event[:event_name] = event_name
        event[:created_at] = Time.now.utc.to_i
        event[:metadata] = event_metadata

        event.to_json
      end
    end
  end
end
