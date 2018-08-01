# frozen_string_literal: true

require 'lucid_intercom'

module LucidIntercom
  class Response
    #
    # @abstract
    #
    class Error < LucidIntercom::Error
      extend Dry::Initializer

      # @return [Integer]
      param :status_code

      #
      # @return [String]
      #
      def message
        "bad response (#{status_code})"
      end
    end

    ClientError = Class.new(Error)
    ServerError = Class.new(Error)

    extend Dry::Initializer

    # @return [Integer]
    param :status_code

    #
    # @return [Boolean]
    #
    # @raise [ClientError] for status 4xx
    # @raise [ServerError] for status 5xx
    #
    def assert!
      case status_code
      when 400..499
        raise ClientError.new(status_code)
      when 500..599
        raise ServerError.new(status_code)
      end

      true
    end
  end
end
