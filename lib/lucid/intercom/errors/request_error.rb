require_relative './error'

module Lucid
  module Intercom
    class RequestError < Error
      attr_reader :status

      #
      # @param status [Integer] the HTTP response status
      #
      def initialize(status)
        @status = status
      end
    end
  end
end
