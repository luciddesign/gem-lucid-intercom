# frozen_string_literal: true

require 'json'

require 'lucid_intercom'

module LucidIntercom
  class Response
    #
    # @abstract
    #
    class Error < LucidIntercom::Error
      extend Dry::Initializer

      # @return [Response]
      param :response

      #
      # @return [String]
      #
      def message
        "bad response (#{response.status_code})"
      end
    end

    ClientError = Class.new(Error)
    ServerError = Class.new(Error)

    extend Dry::Initializer

    # @return [Integer]
    param :status_code
    # @return [Hash]
    param :headers
    # @return [String]
    param :data
    # @return [Hash] the parsed response body
    param :data_hash, default: -> { parse_data }

    #
    # @return [Hash]
    #
    private def parse_data
      return {} unless json?

      JSON.parse(data)
    end

    #
    # @return [Boolean]
    #
    private def json?
      headers['Content-Type'] =~ /application\/json/
    end

    #
    # @return [self]
    #
    # @raise [ClientError] for status 4xx
    # @raise [ServerError] for status 5xx
    #
    def assert!
      case status_code
      when 400..499
        raise ClientError.new(self)
      when 500..599
        raise ServerError.new(self)
      end

      self
    end
  end
end
