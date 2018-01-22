require 'json'
require 'net/http'
require 'uri'
require 'lucid_intercom/attributes'
require 'lucid_intercom/credentials'
require 'lucid_intercom/errors'

module LucidIntercom
  class SendEvent
    #
    # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
    # @param credentials [LucidIntercom::Credentials]
    #
    def initialize(shop_attributes, credentials: LucidIntercom.credentials)
      @attributes = Attributes.new(shop_attributes, {}, credentials: credentials)
      @credentials = credentials
    end

    # @return [LucidIntercom::Attributes]
    attr_reader :attributes
    # @return [LucidIntercom::Credentials]
    attr_reader :credentials

    #
    # Send event for user identified by attributes.
    #
    # @param event_name [String]
    # @param event_metadata [Hash]
    #
    # @raise [LucidIntercom::RequestError] if the response status >= 400
    #
    def call(event_name, event_metadata)
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req, data(event_name, event_metadata))
      end

      status = res.code.to_i

      if status >= 400
        raise LucidIntercom::RequestError.new(status), 'invalid response code %s' % status
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
