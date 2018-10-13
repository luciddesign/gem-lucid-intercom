# frozen_string_literal: true

require 'lucid_intercom'

module LucidIntercom
  class PostRequest
    #
    # @param http [HTTP::Client, #headers#post]
    #
    def initialize(http: Container[:http])
      @http = http
    end

    #
    # @param path [String] path relative to the domain
    # @param data [Hash]
    #
    # @return [Response]
    #
    def call(path, data)
      res = @http.headers(
        'Authorization' => "Bearer #{LucidIntercom.access_token}",
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      ).post("https://api.intercom.io/#{path}", json: data)

      Response.new(res.code)
    end
  end
end
