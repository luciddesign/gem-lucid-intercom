require 'json'
require 'net/http'
require 'uri'
require 'lucid_intercom/attributes'
require 'lucid_intercom/credentials'
require 'lucid_intercom/errors'

module LucidIntercom
  class UpdateUser
    #
    # @param shop_attributes [Hash] shop attributes in format returned by the Shopify API
    # @param app_attributes [Hash] app-specific attributes (unprefixed)
    # @param credentials [LucidIntercom::Credentials]
    #
    def initialize(shop_attributes, app_attributes, credentials: LucidIntercom.credentials)
      @attributes = Attributes.new(shop_attributes, app_attributes, credentials: @credentials)
      @credentials = credentials
    end

    # @return [LucidIntercom::Attributes]
    attr_reader :attributes
    # @return [LucidIntercom::Credentials]
    attr_reader :credentials

    #
    # Create or update user identified by attributes.
    #
    # @raise [LucidIntercom::RequestError] if the response status >= 400
    #
    def call
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req, data)
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
