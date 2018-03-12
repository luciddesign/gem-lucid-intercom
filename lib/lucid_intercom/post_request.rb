# frozen_string_literal: true

require 'http'

require 'lucid_intercom/config'
require 'lucid_intercom/response'

module LucidIntercom
  class PostRequest
    #
    # @param path [String] path relative to the domain
    # @param data [Hash]
    #
    # @return [Response]
    #
    def call(path, data)
      res = HTTP.headers(
        'Authorization' => "Bearer #{LucidIntercom.access_token}",
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      ).post("https://api.intercom.io/#{path}", json: data)

      Response.new(res.code)
    end
  end
end
