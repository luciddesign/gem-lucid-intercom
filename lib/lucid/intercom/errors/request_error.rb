module Lucid
  module Intercom
    class RequestError < StandardError
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
