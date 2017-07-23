require 'json'
require 'net/http'
require 'uri'

require_relative '../intercom'
require_relative './attributes'
require_relative './errors'

module Lucid
  module Intercom
    class SendEvent
      #
      # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
      # @param credentials [Lucid::Intercom::Credentials]
      #
      def initialize(shop_attributes, credentials: nil)
        @credentials = credentials || Lucid::Intercom.credentials

        @attributes = Attributes.new(shop_attributes, {}, credentials: @credentials)
      end

      attr_reader :attributes
      attr_reader :credentials

      #
      # Send event for user identified by attributes.
      #
      # @param event_name [String]
      # @param event_metadata [Hash]
      #
      # @raise [Lucid::Intercom::RequestError] if the response status >= 400
      #
      def call(event_name, event_metadata)
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req, data(event_name, event_metadata))
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
        URI('https://api.intercom.io/events')
      end

      #
      # @return [Net::HTTP::Post]
      #
      private def req
        req = Net::HTTP::Post.new(uri)
        req['Authorization'] = "Bearer #{credentials.access_token}"
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
